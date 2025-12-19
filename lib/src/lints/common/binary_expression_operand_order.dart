import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/diagnostic/diagnostic.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class BinaryExpressionOperandOrder extends DartLintRule {
  const BinaryExpressionOperandOrder() : super(code: _code);

  static const _code = LintCode(
    name: 'binary_expression_operand_order',
    problemMessage:
        'Literal value should be on the right side of the operator.',
    correctionMessage:
        'Move the literal to the right side of the binary expression.',
    errorSeverity: analyzer_error.DiagnosticSeverity.INFO,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addBinaryExpression((node) {
      final leftOperand = node.leftOperand;
      final rightOperand = node.rightOperand;

      // Check if left operand is a literal and right is not
      if (_isLiteral(leftOperand) && !_isLiteral(rightOperand)) {
        reporter.atNode(node, _code);
      }
    });
  }

  @override
  List<Fix> getFixes() => [_SwapOperands()];

  static bool _isLiteral(Expression expression) {
    return expression is BooleanLiteral ||
        expression is IntegerLiteral ||
        expression is DoubleLiteral ||
        expression is StringLiteral ||
        expression is NullLiteral ||
        expression is ListLiteral ||
        expression is SetOrMapLiteral ||
        expression is SymbolLiteral;
  }
}

class _SwapOperands extends DartFix {
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

      final leftOperand = node.leftOperand;
      final rightOperand = node.rightOperand;

      // Verify this is the issue we're fixing
      if (!BinaryExpressionOperandOrder._isLiteral(leftOperand) ||
          BinaryExpressionOperandOrder._isLiteral(rightOperand)) {
        return;
      }

      final changeBuilder = reporter.createChangeBuilder(
        message: 'Swap operands',
        priority: 80,
      );

      changeBuilder.addDartFileEdit((builder) {
        final leftText = leftOperand.toSource();
        final rightText = rightOperand.toSource();
        final operator = node.operator.lexeme;

        // Replace the entire binary expression with swapped operands
        builder.addSimpleReplacement(
          node.sourceRange,
          '$rightText $operator $leftText',
        );
      });
    });
  }
}
