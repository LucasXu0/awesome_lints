import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import '../../utils/ast_extensions.dart';

class AvoidAssigningToStaticField extends DartLintRule {
  const AvoidAssigningToStaticField() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_assigning_to_static_field',
    problemMessage: 'Avoid assigning to static fields from instance methods.',
    correctionMessage:
        'Make the method static or refactor to avoid mutable global state.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
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
    DiagnosticReporter reporter,
  ) {
    // Check if we're in an instance method (not static)
    if (!_isInInstanceMethod(node)) {
      return;
    }

    // For AssignmentExpression, use writeElement to get the element being assigned to
    final element = node.writeElement;

    if (element != null && _isStaticField(element)) {
      reporter.atNode(node.leftHandSide, _code);
    }
  }

  void _checkCompoundAssignment(
    AstNode node,
    Expression operand,
    DiagnosticReporter reporter,
  ) {
    // Check if we're in an instance method (not static)
    if (!_isInInstanceMethod(node)) {
      return;
    }

    // For PrefixExpression and PostfixExpression, they implement CompoundAssignmentExpression
    if (node is CompoundAssignmentExpression) {
      final element = node.writeElement;

      if (element != null && _isStaticField(element)) {
        reporter.atNode(operand, _code);
      }
    }
  }

  bool _isStaticField(Element element) {
    if (element is PropertyAccessorElement) {
      final variable = element.variable;
      return variable.isStatic;
    } else if (element is VariableElement) {
      return element.isStatic;
    }
    return false;
  }

  bool _isInInstanceMethod(AstNode node) {
    // Find enclosing method declaration
    final method = node.findAncestorOfType<MethodDeclaration>();
    if (method == null) return false;

    // If it's a static method, return false
    return !method.isStatic;
  }
}
