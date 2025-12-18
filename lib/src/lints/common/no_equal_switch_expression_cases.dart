import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class NoEqualSwitchExpressionCases extends DartLintRule {
  const NoEqualSwitchExpressionCases() : super(code: _code);

  static const _code = LintCode(
    name: 'no_equal_switch_expression_cases',
    problemMessage:
        'This switch expression case has the same body as a previous case. Consider combining them.',
    correctionMessage:
        'Combine cases with identical expressions using the OR operator (||).',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addSwitchExpression((node) {
      final caseBodies = <String, SwitchExpressionCase>{};

      for (final caseNode in node.cases) {
        // Get the expression body as a string
        final body = caseNode.expression.toString();

        // Check if we've seen this body before
        if (caseBodies.containsKey(body)) {
          // Report on the duplicate case
          reporter.atNode(
            caseNode,
            _code,
          );
        } else {
          // Store this body for future comparison
          caseBodies[body] = caseNode;
        }
      }
    });
  }
}
