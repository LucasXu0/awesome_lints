import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class DisposeClassFields extends DartLintRule {
  const DisposeClassFields() : super(code: _code);

  static const _code = LintCode(
    name: 'dispose_class_fields',
    problemMessage:
        'Field has a disposal method but is not disposed in the cleanup method.',
    correctionMessage:
        'Call the disposal method (dispose, close, or cancel) in the class cleanup method.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  static const _disposalMethods = ['dispose', 'close', 'cancel'];

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addClassDeclaration((node) {
      // Find all fields in the class
      final fields = <FieldDeclaration>[];
      for (final member in node.members) {
        if (member is FieldDeclaration) {
          fields.add(member);
        }
      }

      if (fields.isEmpty) return;

      // Find the cleanup method (dispose, close)
      MethodDeclaration? cleanupMethod;
      String? cleanupMethodName;

      for (final methodName in _disposalMethods) {
        for (final member in node.members) {
          if (member is MethodDeclaration &&
              member.name.lexeme == methodName &&
              member.parameters?.parameters.isEmpty == true) {
            cleanupMethod = member;
            cleanupMethodName = methodName;
            break;
          }
        }
        if (cleanupMethod != null) break;
      }

      // If no cleanup method exists, skip checking
      if (cleanupMethod == null || cleanupMethodName == null) return;

      // Get all disposal calls in the cleanup method
      final disposedFields = <String>{};
      cleanupMethod.body.visitChildren(_DisposalVisitor(disposedFields));

      // Check each field to see if it has a disposal method
      for (final field in fields) {
        for (final variable in field.fields.variables) {
          final fieldName = variable.name.lexeme;
          final fieldType = variable.declaredFragment?.element.type;

          if (fieldType != null && _hasDisposalMethod(fieldType)) {
            // Check if this field is disposed
            if (!disposedFields.contains(fieldName)) {
              reporter.atNode(variable, _code);
            }
          }
        }
      }
    });
  }

  bool _hasDisposalMethod(DartType type) {
    if (type is! InterfaceType) return false;

    final element = type.element;

    // Check if the type has any of the disposal methods
    // Use lookUpMethod to search through the class hierarchy
    for (final methodName in _disposalMethods) {
      final method = type.lookUpMethod(methodName, element.library);
      if (method != null) {
        return true;
      }
    }

    return false;
  }
}

class _DisposalVisitor extends RecursiveAstVisitor<void> {
  final Set<String> disposedFields;

  _DisposalVisitor(this.disposedFields);

  @override
  void visitMethodInvocation(MethodInvocation node) {
    // Check for patterns like: _field.dispose(), _field.close(), etc.
    final target = node.target;
    if (target is SimpleIdentifier) {
      final methodName = node.methodName.name;
      if (DisposeClassFields._disposalMethods.contains(methodName)) {
        disposedFields.add(target.name);
      }
    } else if (target is PrefixedIdentifier) {
      final methodName = node.methodName.name;
      if (DisposeClassFields._disposalMethods.contains(methodName)) {
        disposedFields.add(target.identifier.name);
      }
    }

    super.visitMethodInvocation(node);
  }
}
