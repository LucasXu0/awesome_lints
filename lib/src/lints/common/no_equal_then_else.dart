import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class NoEqualThenElse extends DartLintRule {
  const NoEqualThenElse() : super(code: _code);

  static const _code = LintCode(
    name: 'no_equal_then_else',
    problemMessage:
        'The then and else branches contain identical code, making the condition redundant.',
    correctionMessage:
        'Remove the conditional statement and use the common code directly.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    // Check if statements
    context.registry.addIfStatement((node) {
      final elseStatement = node.elseStatement;
      if (elseStatement == null) {
        return;
      }

      // Skip else-if chains
      if (elseStatement is IfStatement) {
        return;
      }

      final thenStatement = node.thenStatement;

      // Compare the source code of both branches
      if (_areStatementsEqual(thenStatement, elseStatement)) {
        reporter.atNode(node.expression, _code);
      }
    });

    // Check conditional expressions (ternary operator)
    context.registry.addConditionalExpression((node) {
      if (_areExpressionsEqual(node.thenExpression, node.elseExpression)) {
        reporter.atNode(node.condition, _code);
      }
    });
  }

  /// Compares two statements for equality based on their source code.
  bool _areStatementsEqual(Statement stmt1, Statement stmt2) {
    // Get the source code representation, normalized for comparison
    final source1 = _normalizeSource(stmt1.toSource());
    final source2 = _normalizeSource(stmt2.toSource());

    return source1 == source2;
  }

  /// Compares two expressions for equality based on their source code.
  bool _areExpressionsEqual(Expression expr1, Expression expr2) {
    // Get the source code representation, normalized for comparison
    final source1 = _normalizeSource(expr1.toSource());
    final source2 = _normalizeSource(expr2.toSource());

    return source1 == source2;
  }

  /// Normalizes source code by removing extra whitespace for comparison.
  String _normalizeSource(String source) {
    // Remove leading/trailing whitespace and normalize internal whitespace
    return source.trim().replaceAll(RegExp(r'\s+'), ' ');
  }
}
