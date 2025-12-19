import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferCorrectBlocProvider extends DartLintRule {
  const PreferCorrectBlocProvider() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_correct_bloc_provider',
    problemMessage: 'Use BlocProvider instead of Provider for Bloc instances.',
    correctionMessage:
        'Replace Provider with BlocProvider to properly provide Bloc instances.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      final type = node.constructorName.type.name.lexeme;

      // Check if it's a Provider (not BlocProvider)
      if (type != 'Provider') return;

      // Check if the type argument is a Bloc or Cubit
      final typeArguments = node.constructorName.type.typeArguments?.arguments;
      if (typeArguments == null || typeArguments.isEmpty) return;

      final providedType = typeArguments.first;
      if (_isBlockOrCubitType(providedType)) {
        reporter.atNode(node.constructorName, _code);
      }
    });
  }

  bool _isBlockOrCubitType(TypeAnnotation type) {
    final typeName = type.toString();
    // Simple heuristic: check if the type name contains 'Bloc' or 'Cubit'
    return typeName.contains('Bloc') || typeName.contains('Cubit');
  }
}
