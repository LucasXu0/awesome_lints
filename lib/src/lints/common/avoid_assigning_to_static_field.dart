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
    if (!_isInInstanceMethod(node)) {
      return;
    }

    // Check if the assignment target is a static field
    bool isStaticField = false;

    if (leftHandSide is SimpleIdentifier) {
      final element = leftHandSide.element;
      isStaticField = _isStaticField(element);
    } else if (leftHandSide is PrefixedIdentifier) {
      final element = leftHandSide.identifier.element;
      isStaticField = _isStaticField(element);
    } else if (leftHandSide is PropertyAccess) {
      final element = leftHandSide.propertyName.element;
      isStaticField = _isStaticField(element);
    }

    if (isStaticField) {
      reporter.atNode(
        leftHandSide,
        _code,
      );
    }
  }

  bool _isStaticField(Element2? element) {
    if (element is PropertyAccessorElement2) {
      final variable = element.variable3;
      return variable != null && variable.isStatic;
    } else if (element is VariableElement2) {
      return element.isStatic;
    }
    return false;
  }

  bool _isInInstanceMethod(AstNode node) {
    AstNode? current = node;
    while (current != null) {
      if (current is MethodDeclaration) {
        // If it's a static method, return false
        return !current.isStatic;
      }
      current = current.parent;
    }
    // Not in a method at all
    return false;
  }
}
