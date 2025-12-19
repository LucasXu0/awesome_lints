import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferSealedBlocState extends DartLintRule {
  const PreferSealedBlocState() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_sealed_bloc_state',
    problemMessage:
        'Bloc state classes should have a sealed or final modifier.',
    correctionMessage:
        'Add sealed modifier to the base state class or final to concrete state classes.',
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
