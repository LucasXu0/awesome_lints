import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferImmutableBlocState extends DartLintRule {
  const PreferImmutableBlocState() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_immutable_bloc_state',
    problemMessage: 'Bloc state classes should have the @immutable annotation.',
    correctionMessage: 'Add @immutable annotation to the state class.',
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

      // Check if class name ends with 'State' (default pattern)
      if (!className.endsWith('State')) return;

      // Skip private classes (Flutter widget states are typically private)
      if (className.startsWith('_')) return;

      // Skip classes that extend Flutter's State class
      final extendsClause = node.extendsClause;
      if (extendsClause != null) {
        final superclassName = extendsClause.superclass.name.lexeme;
        if (superclassName == 'State' || superclassName.contains('State<')) {
          return;
        }
      }

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
