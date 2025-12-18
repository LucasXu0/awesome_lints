import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidAdjacentStrings extends DartLintRule {
  const AvoidAdjacentStrings() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_adjacent_strings',
    problemMessage: 'Avoid using adjacent string literals.',
    correctionMessage:
        'Combine adjacent strings into a single string literal or use string interpolation.',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addAdjacentStrings((node) {
      // AdjacentStrings node represents string literals placed side-by-side
      // This is the exact pattern we want to flag
      reporter.atNode(
        node,
        _code,
      );
    });
  }
}
