import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidComplexLoopConditions extends DartLintRule {
  const AvoidComplexLoopConditions() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_complex_loop_conditions',
    problemMessage:
        'Avoid complex loop conditions that combine multiple logical operations.',
    correctionMessage:
        'Consider simplifying the loop condition or moving additional checks into the loop body.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addForStatement((node) {
      final forLoopParts = node.forLoopParts;
      if (forLoopParts is ForParts) {
        final condition = forLoopParts.condition;
        if (condition != null) {
          _checkCondition(condition, reporter);
        }
      }
    });

    context.registry.addWhileStatement((node) {
      _checkCondition(node.condition, reporter);
    });

    context.registry.addDoStatement((node) {
      _checkCondition(node.condition, reporter);
    });
  }

  void _checkCondition(Expression condition, DiagnosticReporter reporter) {
    // Check through parenthesized expressions
    if (condition is ParenthesizedExpression) {
      _checkCondition(condition.expression, reporter);
      return;
    }

    // Check if condition is a binary expression with logical operators
    if (condition is BinaryExpression) {
      final isLogicalOperator =
          condition.operator.type == TokenType.AMPERSAND_AMPERSAND ||
          condition.operator.type == TokenType.BAR_BAR;

      if (isLogicalOperator) {
        reporter.atNode(condition, _code);
      }
    }
  }
}
