import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class NoEmptyString extends DartLintRule {
  const NoEmptyString() : super(code: _code);

  static const _code = LintCode(
    name: 'no_empty_string',
    problemMessage:
        'Avoid using empty string literals as they may indicate incomplete code.',
    correctionMessage:
        'Replace with a meaningful value or use a named constant for valid empty string use cases.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addSimpleStringLiteral((node) {
      // Check if the string is empty
      if (node.value.isEmpty) {
        reporter.atNode(node, _code);
      }
    });
  }
}
