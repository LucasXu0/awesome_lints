import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class DoubleLiteralFormat extends DartLintRule {
  const DoubleLiteralFormat() : super(code: _code);

  static const _code = LintCode(
    name: 'double_literal_format',
    problemMessage: 'Double literal has incorrect formatting.',
    correctionMessage:
        'Use proper formatting: add leading 0 before decimal point, remove trailing zeros, and avoid unnecessary leading zeros.',
    errorSeverity: analyzer_error.ErrorSeverity.INFO,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addDoubleLiteral((node) {
      final source = node.toSource();

      // Check for missing leading 0 (e.g., .257 instead of 0.257)
      if (source.startsWith('.')) {
        reporter.atNode(
          node,
          _code,
        );
        return;
      }

      // Check for redundant trailing 0 (e.g., 0.210 instead of 0.21)
      if (source.contains('.')) {
        final parts = source.split('.');
        if (parts.length == 2) {
          final decimalPart = parts[1];
          if (decimalPart.endsWith('0') && decimalPart.length > 1) {
            reporter.atNode(
              node,
              _code,
            );
            return;
          }

          // Check for unnecessary leading zeros (e.g., 05.23 instead of 5.23)
          final integerPart = parts[0];
          if (integerPart.length > 1 &&
              integerPart.startsWith('0') &&
              !integerPart.startsWith('0.')) {
            reporter.atNode(
              node,
              _code,
            );
            return;
          }
        }
      }
    });
  }
}
