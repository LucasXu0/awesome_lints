import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidDoubleSlashImports extends DartLintRule {
  const AvoidDoubleSlashImports() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_double_slash_imports',
    problemMessage:
        'Import/export URIs should not contain double slashes as they can cause runtime issues.',
    correctionMessage: 'Replace double slashes with a single slash.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addImportDirective((node) {
      final uri = node.uri.stringValue;
      if (uri != null && uri.contains('//')) {
        reporter.atNode(node.uri, _code);
      }
    });

    context.registry.addExportDirective((node) {
      final uri = node.uri.stringValue;
      if (uri != null && uri.contains('//')) {
        reporter.atNode(node.uri, _code);
      }
    });

    context.registry.addPartDirective((node) {
      final uri = node.uri.stringValue;
      if (uri != null && uri.contains('//')) {
        reporter.atNode(node.uri, _code);
      }
    });
  }
}
