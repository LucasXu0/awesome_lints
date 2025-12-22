import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/diagnostic/diagnostic.dart';
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
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addBinaryExpression((node) {
      // Check if the operator is == or !=
      final isEqualityOperator =
          node.operator.type == TokenType.EQ_EQ ||
          node.operator.type == TokenType.BANG_EQ;

      if (!isEqualityOperator) return;

      // Check if either operand is a boolean literal
      final isLeftBooleanLiteral = node.leftOperand is BooleanLiteral;
      final isRightBooleanLiteral = node.rightOperand is BooleanLiteral;

      if (isLeftBooleanLiteral || isRightBooleanLiteral) {
        reporter.atNode(node, _code);
      }
    });
  }

  @override
  List<Fix> getFixes() => [_SimplifyBooleanComparison()];
}

class _SimplifyBooleanComparison extends DartFix {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    Diagnostic analysisError,
    List<Diagnostic> others,
  ) {
    context.registry.addBinaryExpression((node) {
      if (!analysisError.sourceRange.intersects(node.sourceRange)) return;

      final isEqualityOperator =
          node.operator.type == TokenType.EQ_EQ ||
          node.operator.type == TokenType.BANG_EQ;

      if (!isEqualityOperator) return;

      final isLeftBooleanLiteral = node.leftOperand is BooleanLiteral;
      final isRightBooleanLiteral = node.rightOperand is BooleanLiteral;

      if (!isLeftBooleanLiteral && !isRightBooleanLiteral) return;

      // Determine which operand is the boolean value (not literal)
      final booleanValue = isLeftBooleanLiteral
          ? node.rightOperand
          : node.leftOperand;
      final booleanLiteral = isLeftBooleanLiteral
          ? node.leftOperand as BooleanLiteral
          : node.rightOperand as BooleanLiteral;

      // Determine if we need to negate
      final isEquality = node.operator.type == TokenType.EQ_EQ;
      final literalValue = booleanLiteral.value;

      // Logic:
      // value == true  → value
      // value == false → !value
      // value != true  → !value
      // value != false → value
      final needsNegation =
          (isEquality && !literalValue) || (!isEquality && literalValue);

      final replacement = needsNegation
          ? '!${booleanValue.toSource()}'
          : booleanValue.toSource();

      final changeBuilder = reporter.createChangeBuilder(
        message: 'Simplify boolean comparison',
        priority: 80,
      );

      changeBuilder.addDartFileEdit((builder) {
        builder.addSimpleReplacement(node.sourceRange, replacement);
      });
    });
  }
}
