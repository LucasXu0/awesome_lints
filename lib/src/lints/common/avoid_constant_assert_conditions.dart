import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidConstantAssertConditions extends DartLintRule {
  const AvoidConstantAssertConditions() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_constant_assert_conditions',
    problemMessage:
        'Avoid assert statements with constant conditions that are always true or always false.',
    correctionMessage:
        'Remove assertions with constant conditions or use dynamic conditions that can actually fail.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addAssertStatement((node) {
      final condition = node.condition;

      if (_isConstantExpression(condition)) {
        reporter.atNode(condition, _code);
      }
    });
  }

  bool _isConstantExpression(Expression expression) {
    // Check for boolean literals
    if (expression is BooleanLiteral) {
      return true;
    }

    // Check for integer/double literals (assert(1), assert(0), etc.)
    if (expression is IntegerLiteral || expression is DoubleLiteral) {
      return true;
    }

    // Check for string literals
    if (expression is StringLiteral) {
      return true;
    }

    // Check for null literals
    if (expression is NullLiteral) {
      return true;
    }

    // Check for const constructor invocations
    if (expression is InstanceCreationExpression &&
        expression.keyword?.lexeme == 'const') {
      return true;
    }

    // Check for const list/set/map literals
    if (expression is ListLiteral && expression.constKeyword != null) {
      return true;
    }
    if (expression is SetOrMapLiteral && expression.constKeyword != null) {
      return true;
    }

    // Check for simple binary expressions with constants
    if (expression is BinaryExpression) {
      final leftIsConstant = _isConstantExpression(expression.leftOperand);
      final rightIsConstant = _isConstantExpression(expression.rightOperand);

      // If both sides are constants, the result is constant
      if (leftIsConstant && rightIsConstant) {
        return true;
      }
    }

    // Check for parenthesized constant expressions
    if (expression is ParenthesizedExpression) {
      return _isConstantExpression(expression.expression);
    }

    // Check for prefix expressions (like !true)
    if (expression is PrefixExpression) {
      return _isConstantExpression(expression.operand);
    }

    // Check for identifiers that reference const values
    // Note: This is a simplified check. Full const evaluation would require more complex analysis.
    if (expression is SimpleIdentifier) {
      // We can't easily check if a variable is const without more complex analysis
      // So we skip this check to avoid false positives
    }

    return false;
  }
}
