import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import '../../utils/ast_extensions.dart';
import '../../utils/disposal_utils.dart';

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
          // Skip fields that are initialized from external sources
          if (_isExternallyOwned(variable)) {
            continue;
          }
          disposableFields.add(member);
          break; // Only add the field declaration once
        }
      }
    }

    return disposableFields;
  }

  /// Checks if the type has dispose(), close(), or cancel() methods
  bool _hasDisposableMethod(DartType type) {
    return DisposalUtils.hasDisposalMethod(type);
  }

  /// Checks if a field is externally owned (from context, DI, etc.)
  /// and should not be disposed by this class
  bool _isExternallyOwned(VariableDeclaration variable) {
    final initializer = variable.initializer;
    if (initializer == null) return false;

    // Check for common patterns of external ownership
    if (initializer is MethodInvocation) {
      final methodName = initializer.methodName.name;
      final target = initializer.target;

      // Check for context.read<T>(), context.watch<T>(), Provider.of<T>(context)
      if (target != null) {
        final targetName = target.simpleIdentifierName;
        if (targetName == 'context') {
          // context.read(), context.watch(), etc.
          if (methodName == 'read' ||
              methodName == 'watch' ||
              methodName == 'select') {
            return true;
          }
        }

        // Provider.of(context), GetIt.instance.get(), etc.
        if (methodName == 'of' || methodName == 'get' || methodName == 'find') {
          return true;
        }
      }

      // Check for Provider.of(context, ...) pattern (no target)
      if (target == null && methodName == 'of') {
        // Check if first argument is 'context'
        final args = initializer.argumentList.arguments;
        if (args.isNotEmpty) {
          final firstArg = args.first;
          if (firstArg is SimpleIdentifier && firstArg.name == 'context') {
            return true;
          }
        }
      }
    }

    // Check for widget.something (passed from parent widget)
    if (initializer is PropertyAccess || initializer is PrefixedIdentifier) {
      final targetName = _getTargetName(initializer);
      if (targetName == 'widget') {
        return true;
      }
    }

    return false;
  }

  /// Extracts target name from PropertyAccess or PrefixedIdentifier
  String? _getTargetName(Expression expression) {
    if (expression is PropertyAccess) {
      return expression.target?.simpleIdentifierName;
    }
    if (expression is PrefixedIdentifier) {
      return expression.prefix.name;
    }
    return null;
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

    // Check if it's a disposal method call
    if (!DisposalUtils.disposalMethods.contains(methodName)) {
      super.visitMethodInvocation(node);
      return;
    }

    final target = node.target;

    // Extract the field name using the extension method
    final fieldName = target?.simpleIdentifierName;
    if (fieldName != null) {
      disposedFields.add(fieldName);
    }

    super.visitMethodInvocation(node);
  }
}
