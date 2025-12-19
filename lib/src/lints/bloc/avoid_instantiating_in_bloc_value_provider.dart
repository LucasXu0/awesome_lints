import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidInstantiatingInBlocValueProvider extends DartLintRule {
  const AvoidInstantiatingInBlocValueProvider() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_instantiating_in_bloc_value_provider',
    problemMessage:
        'BlocProvider.value should reuse an existing instance instead of creating a new one.',
    correctionMessage:
        'Pass an existing instance to the value parameter instead of instantiating inline.',
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
      final constructor = node.constructorName.name?.name;

      if (type != 'BlocProvider' || constructor != 'value') return;

      // Check for value parameter
      for (final arg in node.argumentList.arguments) {
        if (arg is NamedExpression && arg.name.label.name == 'value') {
          final expression = arg.expression;

          // Check if the value is an instance creation
          if (expression is InstanceCreationExpression) {
            reporter.atNode(expression, _code);
          }
        }
      }
    });
  }
}
