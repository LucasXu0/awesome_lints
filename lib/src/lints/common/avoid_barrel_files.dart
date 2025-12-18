import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidBarrelFiles extends DartLintRule {
  const AvoidBarrelFiles() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_barrel_files',
    problemMessage:
        'Avoid barrel files that only re-export declarations from other modules.',
    correctionMessage:
        'Consider importing directly from the source files or add local declarations to this file.',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addCompilationUnit((node) {
      // Check if the file has any directives
      if (node.directives.isEmpty) return;

      // Check if all directives are export directives
      final hasOnlyExports = node.directives.every(
        (directive) =>
            directive is ExportDirective || directive is LibraryDirective,
      );

      // Check if there are any declarations (classes, functions, etc.)
      final hasDeclarations = node.declarations.isNotEmpty;

      // If the file has only exports and no local declarations, it's a barrel file
      if (hasOnlyExports && !hasDeclarations) {
        // Report on the first export directive
        final firstExport = node.directives.whereType<ExportDirective>().first;
        reporter.atNode(
          firstExport,
          _code,
        );
      }
    });
  }
}
