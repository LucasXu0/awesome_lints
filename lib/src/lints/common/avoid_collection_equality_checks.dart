import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidCollectionEqualityChecks extends DartLintRule {
  const AvoidCollectionEqualityChecks() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_collection_equality_checks',
    problemMessage:
        'Avoid using == or != to compare collections as it uses reference equality, not deep equality.',
    correctionMessage:
        'Use collection equality packages like collection or package:collection for deep equality checks, or compare individual elements.',
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

      // Get the types of both operands
      final leftType = node.leftOperand.staticType;
      final rightType = node.rightOperand.staticType;

      if (leftType == null || rightType == null) return;

      // Check if either operand is a collection type (not const)
      final leftIsCollection =
          _isCollectionType(leftType) && !_isConstExpression(node.leftOperand);
      final rightIsCollection =
          _isCollectionType(rightType) &&
          !_isConstExpression(node.rightOperand);

      if (leftIsCollection || rightIsCollection) {
        reporter.atNode(node, _code);
      }
    });
  }

  bool _isCollectionType(DartType type) {
    return type.isDartCoreList || type.isDartCoreSet || type.isDartCoreMap;
  }

  bool _isConstExpression(Expression expression) {
    // Check if expression is a const list/set/map literal
    if (expression is ListLiteral && expression.constKeyword != null) {
      return true;
    }
    if (expression is SetOrMapLiteral && expression.constKeyword != null) {
      return true;
    }

    // Check if it's a const constructor invocation
    if (expression is InstanceCreationExpression &&
        expression.keyword?.lexeme == 'const') {
      return true;
    }

    // Check if wrapped in parentheses
    if (expression is ParenthesizedExpression) {
      return _isConstExpression(expression.expression);
    }

    return false;
  }
}
