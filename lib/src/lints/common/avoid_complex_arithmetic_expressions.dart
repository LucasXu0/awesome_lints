import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidComplexArithmeticExpressions extends DartLintRule {
  const AvoidComplexArithmeticExpressions() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_complex_arithmetic_expressions',
    problemMessage:
        'Avoid complex arithmetic expressions with too many operations.',
    correctionMessage:
        'Consider breaking the expression into multiple lines or extracting it into a separate method with a descriptive name.',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  static const int _maxOperations = 6;

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addBinaryExpression((node) {
      // Only check if this is an arithmetic operation
      if (!_isArithmeticOperator(node.operator.type)) {
        return;
      }

      // Check if this is the root of an arithmetic expression tree
      // (not nested inside another arithmetic expression)
      final parent = node.parent;
      if (parent is BinaryExpression &&
          _isArithmeticOperator(parent.operator.type)) {
        // This node is nested, let the parent handle it
        return;
      }

      // Count operations in the entire expression tree
      final operationCount = _countArithmeticOperations(node);

      if (operationCount > _maxOperations) {
        reporter.atNode(
          node,
          _code,
        );
      }
    });
  }

  bool _isArithmeticOperator(TokenType type) {
    return type == TokenType.PLUS ||
        type == TokenType.MINUS ||
        type == TokenType.STAR ||
        type == TokenType.SLASH ||
        type == TokenType.PERCENT ||
        type == TokenType.TILDE_SLASH; // ~/
  }

  int _countArithmeticOperations(Expression expression) {
    if (expression is BinaryExpression &&
        _isArithmeticOperator(expression.operator.type)) {
      // Count this operation plus operations in left and right operands
      return 1 +
          _countArithmeticOperations(expression.leftOperand) +
          _countArithmeticOperations(expression.rightOperand);
    }

    // Handle parenthesized expressions
    if (expression is ParenthesizedExpression) {
      return _countArithmeticOperations(expression.expression);
    }

    // Base case: not an arithmetic operation
    return 0;
  }
}
