import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class NoEqualConditions extends DartLintRule {
  const NoEqualConditions() : super(code: _code);

  static const _code = LintCode(
    name: 'no_equal_conditions',
    problemMessage:
        'Duplicate condition found in if-else chain. This branch is unreachable.',
    correctionMessage:
        'Use a different condition or remove the duplicate branch.',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addIfStatement((node) {
      final conditions = <String>[];

      // Collect the initial if condition
      final initialCondition = node.expression.toString();
      conditions.add(initialCondition);

      // Track the current else statement to check for else-if chains
      var currentElse = node.elseStatement;

      while (currentElse != null) {
        // Check if the else statement is another if statement (else if)
        if (currentElse is IfStatement) {
          final condition = currentElse.expression.toString();

          // Check if this condition already exists
          if (conditions.contains(condition)) {
            reporter.atNode(
              currentElse.expression,
              _code,
            );
          } else {
            conditions.add(condition);
          }

          // Move to the next else in the chain
          currentElse = currentElse.elseStatement;
        } else {
          // It's a regular else block, stop checking
          break;
        }
      }
    });
  }
}
