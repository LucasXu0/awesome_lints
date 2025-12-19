import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidContradictoryExpressions extends DartLintRule {
  const AvoidContradictoryExpressions() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_contradictory_expressions',
    problemMessage:
        'This expression contains contradictory conditions that always evaluate to false.',
    correctionMessage:
        'Use OR operator or fix the logic to make conditions non-contradictory.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addBinaryExpression((node) {
      // Only check AND expressions
      if (node.operator.type != TokenType.AMPERSAND_AMPERSAND) {
        return;
      }

      final conditions = _flattenAndConditions(node);
      _checkForContradictions(conditions, reporter);
    });
  }

  /// Flatten nested AND expressions into a list of conditions
  List<Expression> _flattenAndConditions(BinaryExpression node) {
    final conditions = <Expression>[];

    void flatten(Expression expr) {
      if (expr is BinaryExpression &&
          expr.operator.type == TokenType.AMPERSAND_AMPERSAND) {
        flatten(expr.leftOperand);
        flatten(expr.rightOperand);
      } else {
        conditions.add(expr);
      }
    }

    flatten(node);
    return conditions;
  }

  void _checkForContradictions(
    List<Expression> conditions,
    DiagnosticReporter reporter,
  ) {
    for (var i = 0; i < conditions.length; i++) {
      for (var j = i + 1; j < conditions.length; j++) {
        if (_areContradictory(conditions[i], conditions[j])) {
          reporter.atNode(conditions[j], _code);
        }
      }
    }
  }

  bool _areContradictory(Expression expr1, Expression expr2) {
    if (expr1 is! BinaryExpression || expr2 is! BinaryExpression) {
      return false;
    }

    // Get the identifiers being compared
    final id1 = _getIdentifier(expr1.leftOperand);
    final id2 = _getIdentifier(expr2.leftOperand);

    if (id1 == null || id2 == null || id1 != id2) {
      return false;
    }

    // Check for contradictory comparisons
    final op1 = expr1.operator.type;
    final op2 = expr2.operator.type;

    // Same variable compared to different values with ==
    if (op1 == TokenType.EQ_EQ && op2 == TokenType.EQ_EQ) {
      final val1 = _getLiteralValue(expr1.rightOperand);
      final val2 = _getLiteralValue(expr2.rightOperand);
      if (val1 != null && val2 != null && val1 != val2) {
        return true;
      }
    }

    // x == value && x != value
    if ((op1 == TokenType.EQ_EQ && op2 == TokenType.BANG_EQ) ||
        (op1 == TokenType.BANG_EQ && op2 == TokenType.EQ_EQ)) {
      final val1 = _getLiteralValue(expr1.rightOperand);
      final val2 = _getLiteralValue(expr2.rightOperand);
      if (val1 != null && val2 != null && val1 == val2) {
        return true;
      }
    }

    // x < value && x > value (or >= and <=)
    if ((op1 == TokenType.LT && op2 == TokenType.GT) ||
        (op1 == TokenType.GT && op2 == TokenType.LT)) {
      final val1 = _getLiteralValue(expr1.rightOperand);
      final val2 = _getLiteralValue(expr2.rightOperand);
      if (val1 != null && val2 != null && val1 == val2) {
        return true;
      }
    }

    return false;
  }

  String? _getIdentifier(Expression expr) {
    if (expr is SimpleIdentifier) {
      return expr.name;
    }
    if (expr is PrefixedIdentifier) {
      return expr.identifier.name;
    }
    return null;
  }

  Object? _getLiteralValue(Expression expr) {
    if (expr is IntegerLiteral) {
      return expr.value;
    }
    if (expr is StringLiteral) {
      return expr.stringValue;
    }
    if (expr is BooleanLiteral) {
      return expr.value;
    }
    if (expr is DoubleLiteral) {
      return expr.value;
    }
    return null;
  }
}
