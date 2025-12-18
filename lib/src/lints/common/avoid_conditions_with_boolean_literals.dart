import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidConditionsWithBooleanLiterals extends DartLintRule {
  const AvoidConditionsWithBooleanLiterals() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_conditions_with_boolean_literals',
    problemMessage:
        'Avoid using boolean literals in logical expressions as they are redundant or make the result constant.',
    correctionMessage:
        'Remove the boolean literal and simplify the expression, or remove the entire condition if it always evaluates to the same value.',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addBinaryExpression((node) {
      // Check if the operator is a logical AND (&&) or OR (||)
      final isLogicalOperator =
          node.operator.type == TokenType.AMPERSAND_AMPERSAND ||
              node.operator.type == TokenType.BAR_BAR;

      if (!isLogicalOperator) return;

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
