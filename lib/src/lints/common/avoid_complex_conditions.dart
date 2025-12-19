import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidComplexConditions extends DartLintRule {
  const AvoidComplexConditions() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_complex_conditions',
    problemMessage:
        'Avoid overly complex conditional expressions that are difficult to understand.',
    correctionMessage:
        'Consider breaking down the condition into smaller, more readable parts or extracting it into a well-named method.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  static const int _maxComplexity = 10;

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addIfStatement((node) {
      _checkCondition(node.expression, reporter);
    });

    context.registry.addWhileStatement((node) {
      _checkCondition(node.condition, reporter);
    });

    context.registry.addDoStatement((node) {
      _checkCondition(node.condition, reporter);
    });

    context.registry.addConditionalExpression((node) {
      _checkCondition(node.condition, reporter);
    });
  }

  void _checkCondition(Expression condition, DiagnosticReporter reporter) {
    final complexity = _calculateComplexity(condition);

    if (complexity > _maxComplexity) {
      reporter.atNode(condition, _code);
    }
  }

  int _calculateComplexity(Expression expression) {
    // Handle parenthesized expressions
    if (expression is ParenthesizedExpression) {
      return _calculateComplexity(expression.expression) + 1; // +1 for nesting
    }

    // Handle binary expressions (logical operators)
    if (expression is BinaryExpression) {
      final isLogicalOperator =
          expression.operator.type == TokenType.AMPERSAND_AMPERSAND ||
          expression.operator.type == TokenType.BAR_BAR;

      if (isLogicalOperator) {
        // Each logical operator adds complexity
        return 2 +
            _calculateComplexity(expression.leftOperand) +
            _calculateComplexity(expression.rightOperand);
      }

      // Other binary expressions (comparisons, etc.) add some complexity
      return 1 +
          _calculateComplexity(expression.leftOperand) +
          _calculateComplexity(expression.rightOperand);
    }

    // Handle prefix expressions (negation)
    if (expression is PrefixExpression) {
      return 1 + _calculateComplexity(expression.operand);
    }

    // Handle conditional expressions (ternary)
    if (expression is ConditionalExpression) {
      return 3 +
          _calculateComplexity(expression.condition) +
          _calculateComplexity(expression.thenExpression) +
          _calculateComplexity(expression.elseExpression);
    }

    // Handle method invocations
    if (expression is MethodInvocation) {
      return 2; // Method calls add complexity
    }

    // Handle property access
    if (expression is PropertyAccess || expression is PrefixedIdentifier) {
      return 1; // Property access adds minor complexity
    }

    // Base case: simple expressions
    return 0;
  }
}
