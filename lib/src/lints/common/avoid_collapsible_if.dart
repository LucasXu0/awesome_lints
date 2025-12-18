import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidCollapsibleIf extends DartLintRule {
  const AvoidCollapsibleIf() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_collapsible_if',
    problemMessage:
        'Nested if statements can be collapsed into a single if with a compound condition.',
    correctionMessage:
        'Combine the conditions using && operator into a single if statement.',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addIfStatement((node) {
      // Only check outer if statements (without else clause)
      if (node.elseStatement != null) {
        return;
      }

      // Check if the then statement is a block
      final thenStatement = node.thenStatement;
      if (thenStatement is! Block) {
        return;
      }

      // Check if the block contains exactly one statement
      final statements = thenStatement.statements;
      if (statements.length != 1) {
        return;
      }

      // Check if that single statement is another if statement
      final innerStatement = statements.first;
      if (innerStatement is! IfStatement) {
        return;
      }

      // Check if the inner if statement has no else clause
      if (innerStatement.elseStatement != null) {
        return;
      }

      // This is a collapsible if - report it
      reporter.atNode(
        node.expression,
        _code,
      );
    });
  }
}
