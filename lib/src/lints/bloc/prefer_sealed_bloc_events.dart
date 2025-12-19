import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferSealedBlocEvents extends DartLintRule {
  const PreferSealedBlocEvents() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_sealed_bloc_events',
    problemMessage:
        'Bloc event classes should have a sealed or final modifier.',
    correctionMessage:
        'Add sealed modifier to the base event class or final to concrete event classes.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addClassDeclaration((node) {
      final className = node.name.lexeme;

      // Check if class name ends with 'Event' (default pattern)
      if (!className.endsWith('Event')) return;

      // Skip private classes
      if (className.startsWith('_')) return;

      // Check if it has sealed or final modifier
      final hasModifier =
          node.sealedKeyword != null ||
          node.finalKeyword != null ||
          node.abstractKeyword != null;

      if (!hasModifier) {
        reporter.atNode(node, _code);
      }
    });
  }
}
