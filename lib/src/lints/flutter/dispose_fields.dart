import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class DisposeFields extends DartLintRule {
  const DisposeFields() : super(code: _code);

  static const _code = LintCode(
    name: 'dispose_fields',
    problemMessage:
        'Field with dispose(), close(), or cancel() method is not disposed in the dispose method.',
    correctionMessage:
        'Call the dispose(), close(), or cancel() method on this field in the dispose method.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addClassDeclaration((node) {
      // Check if the class extends State
      if (!_extendsState(node)) return;

      // Collect fields that have dispose(), close(), or cancel() methods
      final disposableFields = _collectDisposableFields(node);
      if (disposableFields.isEmpty) return;

      // Find the dispose method
      final disposeMethod = _findDisposeMethod(node);

      // If there's no dispose method, all disposable fields are undisposed
      if (disposeMethod == null) {
        for (final field in disposableFields) {
          reporter.atNode(field, _code);
        }
        return;
      }

      // Check which fields are disposed in the dispose method
      final disposedFields = _getDisposedFields(disposeMethod);

      // Report fields that are not disposed
      for (final field in disposableFields) {
        final fieldName = _getFieldName(field);
        if (fieldName != null && !disposedFields.contains(fieldName)) {
          reporter.atNode(field, _code);
        }
      }
    });
  }

  /// Checks if the class extends State
  bool _extendsState(ClassDeclaration node) {
    final extendsClause = node.extendsClause;
    if (extendsClause == null) return false;

    final superclass = extendsClause.superclass;
    final superclassName = superclass.element?.displayName;

    return superclassName == 'State';
  }

  /// Collects all fields that have dispose(), close(), or cancel() methods
  List<FieldDeclaration> _collectDisposableFields(ClassDeclaration node) {
    final disposableFields = <FieldDeclaration>[];

    for (final member in node.members) {
      if (member is! FieldDeclaration) continue;

      // Skip static fields
      if (member.isStatic) continue;

      // Check each variable in the field declaration
      for (final variable in member.fields.variables) {
        // Get the type from the declared element
        final element = variable.declaredFragment?.element;
        if (element == null) continue;

        final dartType = element.type;

        // Check if the type has dispose(), close(), or cancel() methods
        if (_hasDisposableMethod(dartType)) {
          disposableFields.add(member);
          break; // Only add the field declaration once
        }
      }
    }

    return disposableFields;
  }

  /// Checks if the type has dispose(), close(), or cancel() methods
  bool _hasDisposableMethod(DartType type) {
    // Check if it's an InterfaceType (class type)
    if (type is! InterfaceType) return false;

    // Look for dispose(), close(), or cancel() methods
    // Use lookUpMethod to search through the class hierarchy
    final disposeMethod = type.lookUpMethod('dispose', type.element.library);
    final closeMethod = type.lookUpMethod('close', type.element.library);
    final cancelMethod = type.lookUpMethod('cancel', type.element.library);

    return disposeMethod != null || closeMethod != null || cancelMethod != null;
  }

  /// Finds the dispose method in the class
  MethodDeclaration? _findDisposeMethod(ClassDeclaration node) {
    for (final member in node.members) {
      if (member is MethodDeclaration && member.name.lexeme == 'dispose') {
        return member;
      }
    }
    return null;
  }

  /// Gets the list of fields that are disposed in the dispose method
  Set<String> _getDisposedFields(MethodDeclaration disposeMethod) {
    final visitor = _DisposedFieldsVisitor();
    disposeMethod.body.visitChildren(visitor);
    return visitor.disposedFields;
  }

  /// Gets the field name from a field declaration
  String? _getFieldName(FieldDeclaration field) {
    final variables = field.fields.variables;
    if (variables.isEmpty) return null;
    return variables.first.name.lexeme;
  }
}

/// Visitor to detect which fields are disposed in the dispose method
class _DisposedFieldsVisitor extends RecursiveAstVisitor<void> {
  final Set<String> disposedFields = {};

  @override
  void visitMethodInvocation(MethodInvocation node) {
    final methodName = node.methodName.name;

    // Check if it's a dispose(), close(), or cancel() call
    if (methodName != 'dispose' &&
        methodName != 'close' &&
        methodName != 'cancel') {
      super.visitMethodInvocation(node);
      return;
    }

    final target = node.target;

    // Extract the field name from various target types
    final fieldName = _extractFieldName(target);
    if (fieldName != null) {
      disposedFields.add(fieldName);
    }

    super.visitMethodInvocation(node);
  }

  /// Extracts the field name from various expression types
  String? _extractFieldName(Expression? expression) {
    if (expression == null) return null;

    // Handle simple field access: field.dispose()
    if (expression is SimpleIdentifier) {
      return expression.name;
    }

    // Handle prefixed identifier: this.field.dispose()
    if (expression is PrefixedIdentifier) {
      if (expression.prefix.name == 'this') {
        return expression.identifier.name;
      }
    }

    // Handle property access: this.field.dispose()
    if (expression is PropertyAccess) {
      final propertyTarget = expression.target;
      if (propertyTarget is ThisExpression) {
        return expression.propertyName.name;
      }
    }

    // Handle postfix expression: field!.dispose()
    if (expression is PostfixExpression) {
      return _extractFieldName(expression.operand);
    }

    return null;
  }
}
