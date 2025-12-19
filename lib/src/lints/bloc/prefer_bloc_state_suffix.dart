import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferBlocStateSuffix extends DartLintRule {
  const PreferBlocStateSuffix() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_bloc_state_suffix',
    problemMessage:
        'Bloc state class names should match the configured pattern (default: end with "State").',
    correctionMessage:
        'Rename the state class to end with "State" or match the configured pattern.',
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

      // Get the state type from Bloc<Event, State>
      final extendsClause = node.extendsClause;
      if (extendsClause == null) return;

      final superclass = extendsClause.superclass;
      final typeArguments = superclass.typeArguments?.arguments;
      if (typeArguments == null || typeArguments.length < 2) return;

      final stateType = typeArguments[1];
      final stateTypeName = stateType.toString();

      // Check if the state type name ends with 'State'
      if (!stateTypeName.endsWith('State')) {
        reporter.atNode(stateType, _code);
      }
    });
  }

  bool _isBloc(ClassDeclaration node) {
    final extendsClause = node.extendsClause;
    if (extendsClause == null) return false;

    final superclass = extendsClause.superclass;
    final superclassName = superclass.name.lexeme;

    return superclassName == 'Bloc' || superclassName == 'Cubit';
  }
}
