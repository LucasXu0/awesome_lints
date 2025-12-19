import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferBlocEventSuffix extends DartLintRule {
  const PreferBlocEventSuffix() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_bloc_event_suffix',
    problemMessage:
        'Bloc event class names should match the configured pattern (default: end with "Event").',
    correctionMessage:
        'Rename the event class to end with "Event" or match the configured pattern.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addClassDeclaration((node) {
      if (!_isBloc(node)) return;

      // Get the event type from Bloc<Event, State>
      final extendsClause = node.extendsClause;
      if (extendsClause == null) return;

      final superclass = extendsClause.superclass;
      final typeArguments = superclass.typeArguments?.arguments;
      if (typeArguments == null || typeArguments.isEmpty) return;

      final eventType = typeArguments.first;
      final eventTypeName = eventType.toString();

      // Check if the event type name ends with 'Event'
      if (!eventTypeName.endsWith('Event')) {
        reporter.atNode(eventType, _code);
      }
    });
  }

  bool _isBloc(ClassDeclaration node) {
    final extendsClause = node.extendsClause;
    if (extendsClause == null) return false;

    final superclass = extendsClause.superclass;
    final superclassName = superclass.name.lexeme;

    return superclassName == 'Bloc';
  }
}
