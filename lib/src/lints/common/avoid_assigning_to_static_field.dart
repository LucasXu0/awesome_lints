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
      _checkAssignmentExpression(node, reporter);
    });

    context.registry.addPostfixExpression((node) {
      _checkCompoundAssignment(node, node.operand, reporter);
    });

    context.registry.addPrefixExpression((node) {
      _checkCompoundAssignment(node, node.operand, reporter);
    });
  }

  void _checkAssignmentExpression(
    AssignmentExpression node,
    ErrorReporter reporter,
  ) {
    // Check if we're in an instance method (not static)
    if (!_isInInstanceMethod(node)) {
      return;
    }

    // For AssignmentExpression, use writeElement2 to get the element being assigned to
    final element = node.writeElement2;

    if (element != null && _isStaticField(element)) {
      reporter.atNode(
        node.leftHandSide,
        _code,
      );
    }
  }

  void _checkCompoundAssignment(
    AstNode node,
    Expression operand,
    ErrorReporter reporter,
  ) {
    // Check if we're in an instance method (not static)
    if (!_isInInstanceMethod(node)) {
      return;
    }

    // For PrefixExpression and PostfixExpression, they implement CompoundAssignmentExpression
    if (node is CompoundAssignmentExpression) {
      final element = node.writeElement2;

      if (element != null && _isStaticField(element)) {
        reporter.atNode(
          operand,
          _code,
        );
      }
    }
  }

  bool _isStaticField(Element2 element) {
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
