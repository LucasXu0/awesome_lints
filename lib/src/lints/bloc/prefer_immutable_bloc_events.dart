import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferImmutableBlocEvents extends DartLintRule {
  const PreferImmutableBlocEvents() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_immutable_bloc_events',
    problemMessage: 'Bloc event classes should have the @immutable annotation.',
    correctionMessage: 'Add @immutable annotation to the event class.',
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

      // Check if it has @immutable annotation
      final hasImmutable = node.metadata.any((annotation) {
        final name = annotation.name.name;
        return name == 'immutable' || name == 'Immutable';
      });

      if (!hasImmutable) {
        reporter.atNode(node, _code);
      }
    });
  }
}
