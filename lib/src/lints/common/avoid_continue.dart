import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidContinue extends DartLintRule {
  const AvoidContinue() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_continue',
    problemMessage: 'Avoid using continue statements in loops.',
    correctionMessage:
        'Invert the condition to eliminate the need for continue.',
    errorSeverity: analyzer_error.DiagnosticSeverity.INFO,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addContinueStatement((node) {
      reporter.atNode(node, _code);
    });
  }
}
