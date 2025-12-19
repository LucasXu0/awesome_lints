import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferMultiProvider extends DartLintRule {
  const PreferMultiProvider() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_multi_provider',
    problemMessage:
        'Prefer using MultiProvider instead of nesting multiple Provider widgets.',
    correctionMessage:
        'Replace nested Providers with a single MultiProvider for better readability.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      if (!_isProvider(node)) return;

      final childArgument = _getChildProviderArgument(node);
      if (childArgument != null) {
        // Report on the child argument that contains the nested provider
        reporter.atNode(childArgument, _code);
      }
    });
  }

  bool _isProvider(InstanceCreationExpression node) {
    final typeName = node.constructorName.type.name.lexeme;
    // Match any Provider variant except MultiProvider
    return typeName.contains('Provider') &&
        !typeName.contains('Multi') &&
        !typeName.contains('Consumer');
  }

  NamedExpression? _getChildProviderArgument(InstanceCreationExpression node) {
    // Find the 'child' argument
    for (final argument in node.argumentList.arguments) {
      if (argument is NamedExpression && argument.name.label.name == 'child') {
        final childExpression = argument.expression;

        // Check if the child is directly a Provider
        if (childExpression is InstanceCreationExpression) {
          if (_isProvider(childExpression)) {
            return argument;
          }
        }
      }
    }
    return null;
  }
}
