import 'package:analyzer/diagnostic/diagnostic.dart';
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
    errorSeverity: analyzer_error.DiagnosticSeverity.INFO,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addDoubleLiteral((node) {
      final source = node.toSource();

      // Check for missing leading 0 (e.g., .257 instead of 0.257)
      if (source.startsWith('.')) {
        reporter.atNode(node, _code);
        return;
      }

      // Check for redundant trailing 0 (e.g., 0.210 instead of 0.21)
      if (source.contains('.')) {
        final parts = source.split('.');
        if (parts.length == 2) {
          final decimalPart = parts[1];
          if (decimalPart.endsWith('0') && decimalPart.length > 1) {
            reporter.atNode(node, _code);
            return;
          }

          // Check for unnecessary leading zeros (e.g., 05.23 instead of 5.23)
          final integerPart = parts[0];
          if (integerPart.length > 1 &&
              integerPart.startsWith('0') &&
              !integerPart.startsWith('0.')) {
            reporter.atNode(node, _code);
            return;
          }
        }
      }
    });
  }

  @override
  List<Fix> getFixes() => [_FixDoubleLiteralFormat()];
}

class _FixDoubleLiteralFormat extends DartFix {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    Diagnostic analysisError,
    List<Diagnostic> others,
  ) {
    context.registry.addDoubleLiteral((node) {
      if (!analysisError.sourceRange.intersects(node.sourceRange)) return;

      final source = node.toSource();
      String? fixedFormat;

      // Fix missing leading 0 (e.g., .257 → 0.257)
      if (source.startsWith('.')) {
        fixedFormat = '0$source';
      }
      // Fix trailing zeros and leading zeros
      else if (source.contains('.')) {
        final parts = source.split('.');
        if (parts.length == 2) {
          var integerPart = parts[0];
          var decimalPart = parts[1];

          // Remove unnecessary leading zeros (e.g., 05.23 → 5.23)
          if (integerPart.length > 1 &&
              integerPart.startsWith('0') &&
              !integerPart.startsWith('0.')) {
            integerPart = integerPart.replaceFirst(RegExp(r'^0+'), '');
            if (integerPart.isEmpty) integerPart = '0';
          }

          // Remove trailing zeros (e.g., 0.210 → 0.21)
          if (decimalPart.endsWith('0') && decimalPart.length > 1) {
            decimalPart = decimalPart.replaceAll(RegExp(r'0+$'), '');
          }

          fixedFormat = '$integerPart.$decimalPart';
        }
      }

      if (fixedFormat != null && fixedFormat != source) {
        final changeBuilder = reporter.createChangeBuilder(
          message: 'Format double literal',
          priority: 80,
        );

        changeBuilder.addDartFileEdit((builder) {
          builder.addSimpleReplacement(node.sourceRange, fixedFormat!);
        });
      }
    });
  }
}
