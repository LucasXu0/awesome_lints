import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidAssignmentsAsConditions extends DartLintRule {
  const AvoidAssignmentsAsConditions() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_assignments_as_conditions',
    problemMessage: 'Avoid using assignments as conditions.',
    correctionMessage: 'Move the assignment outside the conditional statement.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addIfStatement((node) {
      _checkCondition(node.expression, reporter);
    });

    context.registry.addWhileStatement((node) {
      _checkCondition(node.condition, reporter);
    });

    context.registry.addDoStatement((node) {
      _checkCondition(node.condition, reporter);
    });

    context.registry.addConditionalExpression((node) {
      _checkCondition(node.condition, reporter);
    });

    context.registry.addForStatement((node) {
      final forLoopParts = node.forLoopParts;
      if (forLoopParts is ForParts) {
        if (forLoopParts.condition != null) {
          _checkCondition(forLoopParts.condition!, reporter);
        }
      }
    });
  }

  void _checkCondition(Expression condition, DiagnosticReporter reporter) {
    // Check for assignment expression (=)
    if (condition is AssignmentExpression) {
      if (condition.operator.type.lexeme == '=' ||
          condition.operator.type.lexeme == '??=') {
        reporter.atNode(condition, _code);
        return;
      }
    }

    // Check for parenthesized assignments
    if (condition is ParenthesizedExpression) {
      _checkCondition(condition.expression, reporter);
      return;
    }

    // Check for assignments in binary expressions (e.g., (x = 5) != null)
    if (condition is BinaryExpression) {
      _checkForAssignment(condition.leftOperand, reporter);
      _checkForAssignment(condition.rightOperand, reporter);
    }
  }

  void _checkForAssignment(Expression expression, DiagnosticReporter reporter) {
    if (expression is AssignmentExpression) {
      if (expression.operator.type.lexeme == '=' ||
          expression.operator.type.lexeme == '??=') {
        reporter.atNode(expression, _code);
      }
    } else if (expression is ParenthesizedExpression) {
      _checkForAssignment(expression.expression, reporter);
    }
  }
}
