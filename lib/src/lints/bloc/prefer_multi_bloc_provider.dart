import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferMultiBlocProvider extends DartLintRule {
  const PreferMultiBlocProvider() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_multi_bloc_provider',
    problemMessage:
        'Replace nested BlocProvider/BlocListener/RepositoryProvider with Multi version.',
    correctionMessage:
        'Use MultiBlocProvider, MultiBlocListener, or MultiRepositoryProvider to reduce nesting.',
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

      if (type != 'BlocProvider' &&
          type != 'BlocListener' &&
          type != 'RepositoryProvider') {
        return;
      }

      // Check if the child is another provider of the same type
      NamedExpression? childArg;
      try {
        childArg = node.argumentList.arguments
            .whereType<NamedExpression>()
            .firstWhere((arg) => arg.name.label.name == 'child');
      } catch (_) {
        // No child argument found
        return;
      }

      if (childArg.expression is InstanceCreationExpression) {
        final childNode = childArg.expression as InstanceCreationExpression;
        final childType = childNode.constructorName.type.name.lexeme;

        // Check if it's the same type of provider
        if (childType == type) {
          reporter.atNode(node.constructorName, _code);
        }
      }
    });
  }
}
