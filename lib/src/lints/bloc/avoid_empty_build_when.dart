import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidEmptyBuildWhen extends DartLintRule {
  const AvoidEmptyBuildWhen() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_empty_build_when',
    problemMessage:
        'BlocBuilder or BlocConsumer should specify a buildWhen condition.',
    correctionMessage:
        'Add a buildWhen parameter to control when the widget should rebuild.',
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

      if (type != 'BlocBuilder' && type != 'BlocConsumer') return;

      // Check if buildWhen parameter is present
      final hasBuildWhen = node.argumentList.arguments.any((arg) {
        if (arg is NamedExpression) {
          return arg.name.label.name == 'buildWhen';
        }
        return false;
      });

      if (!hasBuildWhen) {
        reporter.atNode(node.constructorName, _code);
      }
    });
  }
}
