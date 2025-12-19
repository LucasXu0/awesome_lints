import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferEarlyReturn extends DartLintRule {
  const PreferEarlyReturn() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_early_return',
    problemMessage:
        'The entire function body is wrapped in an if statement. Consider inverting the condition and returning early.',
    correctionMessage:
        'Invert the if condition, return early, and keep the main logic at the base indentation level.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addFunctionBody((node) {
      // Only check block function bodies
      if (node is! BlockFunctionBody) {
        return;
      }

      final block = node.block;
      final statements = block.statements;

      // Must have exactly one statement
      if (statements.length != 1) {
        return;
      }

      // That statement must be an if statement
      final statement = statements.first;
      if (statement is! IfStatement) {
        return;
      }

      // The if statement must not have an else clause
      if (statement.elseStatement != null) {
        return;
      }

      // Report the lint on the if condition
      reporter.atNode(statement.expression, _code);
    });
  }
}
