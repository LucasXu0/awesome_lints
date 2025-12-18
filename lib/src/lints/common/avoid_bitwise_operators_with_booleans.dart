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
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addBinaryExpression((node) {
      // Check if the operator is a bitwise AND or OR
      final isBitwiseOperator = node.operator.type == TokenType.AMPERSAND ||
          node.operator.type == TokenType.BAR;

      if (!isBitwiseOperator) return;

      // Check if either operand is a boolean type
      final leftType = node.leftOperand.staticType;
      final rightType = node.rightOperand.staticType;

      final isLeftBoolean = leftType?.isDartCoreBool ?? false;
      final isRightBoolean = rightType?.isDartCoreBool ?? false;

      if (isLeftBoolean || isRightBoolean) {
        reporter.atNode(
          node,
          _code,
        );
      }
    });
  }
}
