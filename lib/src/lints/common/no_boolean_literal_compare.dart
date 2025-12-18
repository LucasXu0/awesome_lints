import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class NoBooleanLiteralCompare extends DartLintRule {
  const NoBooleanLiteralCompare() : super(code: _code);

  static const _code = LintCode(
    name: 'no_boolean_literal_compare',
    problemMessage:
        'Avoid comparing boolean values to boolean literals (true or false).',
    correctionMessage:
        'Use the boolean value directly or negate it with ! instead of comparing to literals.',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addBinaryExpression((node) {
      // Check if the operator is == or !=
      final isEqualityOperator = node.operator.type == TokenType.EQ_EQ ||
          node.operator.type == TokenType.BANG_EQ;

      if (!isEqualityOperator) return;

      // Check if either operand is a boolean literal
      final isLeftBooleanLiteral = node.leftOperand is BooleanLiteral;
      final isRightBooleanLiteral = node.rightOperand is BooleanLiteral;

      if (isLeftBooleanLiteral || isRightBooleanLiteral) {
        reporter.atNode(
          node,
          _code,
        );
      }
    });
  }
}
