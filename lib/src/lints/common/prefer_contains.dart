import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferContains extends DartLintRule {
  const PreferContains() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_contains',
    problemMessage:
        'Prefer using .contains() instead of .indexOf() comparison with -1.',
    correctionMessage:
        'Replace .indexOf() == -1 with !.contains() or .indexOf() != -1 with .contains().',
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

      // Check if one operand is indexOf() and the other is -1
      final hasIndexOfComparison = _isIndexOfComparedWithMinusOne(node);

      if (hasIndexOfComparison) {
        reporter.atNode(node, _code);
      }
    });
  }

  bool _isIndexOfComparedWithMinusOne(BinaryExpression node) {
    // Check if left operand is indexOf() and right is -1
    if (_isIndexOfMethodInvocation(node.leftOperand) &&
        _isMinusOne(node.rightOperand)) {
      return true;
    }

    // Check if right operand is indexOf() and left is -1
    if (_isIndexOfMethodInvocation(node.rightOperand) &&
        _isMinusOne(node.leftOperand)) {
      return true;
    }

    return false;
  }

  bool _isIndexOfMethodInvocation(Expression expression) {
    if (expression is! MethodInvocation) return false;

    return expression.methodName.name == 'indexOf';
  }

  bool _isMinusOne(Expression expression) {
    // Check for -1 literal
    if (expression is PrefixExpression &&
        expression.operator.type == TokenType.MINUS) {
      final operand = expression.operand;
      if (operand is IntegerLiteral && operand.value == 1) {
        return true;
      }
    }

    return false;
  }
}
