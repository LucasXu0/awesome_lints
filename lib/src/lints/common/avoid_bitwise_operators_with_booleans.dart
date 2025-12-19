import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidBitwiseOperatorsWithBooleans extends DartLintRule {
  const AvoidBitwiseOperatorsWithBooleans() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_bitwise_operators_with_booleans',
    problemMessage:
        'Avoid using bitwise operators (&, |) with boolean expressions.',
    correctionMessage:
        'Use logical operators (&& for AND, || for OR) instead of bitwise operators with booleans.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  bool _isBooleanExpression(Expression? expr) {
    if (expr == null) return false;

    // Unwrap parenthesized expressions
    var unwrapped = expr;
    while (unwrapped is ParenthesizedExpression) {
      unwrapped = unwrapped.expression;
    }

    // Check if it's a boolean literal first (more reliable)
    if (unwrapped is BooleanLiteral) {
      return true;
    }

    // Then check if the static type is bool
    final type = unwrapped.staticType;
    if (type != null && type.isDartCoreBool) {
      return true;
    }

    return false;
  }

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addBinaryExpression((node) {
      // Check if the operator is a bitwise AND or OR
      final isBitwiseOperator =
          node.operator.type == TokenType.AMPERSAND ||
          node.operator.type == TokenType.BAR;

      if (!isBitwiseOperator) return;

      // Check if either operand is a boolean expression
      final isLeftBoolean = _isBooleanExpression(node.leftOperand);
      final isRightBoolean = _isBooleanExpression(node.rightOperand);

      if (isLeftBoolean || isRightBoolean) {
        reporter.atNode(node, _code);
      }
    });
  }
}
