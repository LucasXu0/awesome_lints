import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidAssigningToStaticField extends DartLintRule {
  const AvoidAssigningToStaticField() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_assigning_to_static_field',
    problemMessage: 'Avoid assigning to static fields from instance methods.',
    correctionMessage:
        'Make the method static or refactor to avoid mutable global state.',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addAssignmentExpression((node) {
      _checkAssignment(node, node.leftHandSide, reporter);
    });

    context.registry.addPostfixExpression((node) {
      if (node.operand is SimpleIdentifier) {
        _checkAssignment(node, node.operand as SimpleIdentifier, reporter);
      }
    });

    context.registry.addPrefixExpression((node) {
      if (node.operand is SimpleIdentifier) {
        _checkAssignment(node, node.operand as SimpleIdentifier, reporter);
      }
    });
  }

  void _checkAssignment(
    AstNode node,
    Expression leftHandSide,
    ErrorReporter reporter,
  ) {
    // Check if we're in an instance method (not static)
    final enclosingMethod = _getEnclosingMethod(node);
    if (enclosingMethod == null || enclosingMethod.isStatic) {
      return;
    }

    // Check if the assignment target is a static field
    Element2? element;

    if (leftHandSide is SimpleIdentifier) {
      element = leftHandSide.element;
    } else if (leftHandSide is PrefixedIdentifier) {
      element = leftHandSide.element;
    } else if (leftHandSide is PropertyAccess) {
      element = leftHandSide.propertyName.element;
    }

    if (element is PropertyAccessorElement2) {
      final variable = element.variable3;
      if (variable != null && variable.isStatic) {
        reporter.atNode(
          leftHandSide,
          _code,
        );
      }
    } else if (element is FieldElement2 && element.isStatic) {
      reporter.atNode(
        leftHandSide,
        _code,
      );
    }
  }

  MethodElement2? _getEnclosingMethod(AstNode node) {
    AstNode? current = node;
    while (current != null) {
      if (current is MethodDeclaration) {
        final element = current.declaredFragment?.element;
        return element is MethodElement2 ? element : null;
      }
      current = current.parent;
    }
    return null;
  }
}
