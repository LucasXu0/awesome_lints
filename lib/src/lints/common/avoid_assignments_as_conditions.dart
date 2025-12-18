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
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
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
  }

  void _checkCondition(Expression condition, ErrorReporter reporter) {
    // Check for assignment expression (=)
    if (condition is AssignmentExpression) {
      if (condition.operator.type.lexeme == '=' ||
          condition.operator.type.lexeme == '??=') {
        reporter.atNode(
          condition,
          _code,
        );
      }
    }

    // Check for parenthesized assignments
    if (condition is ParenthesizedExpression) {
      _checkCondition(condition.expression, reporter);
    }
  }
}
