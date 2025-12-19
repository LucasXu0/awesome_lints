import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidWrappingInPadding extends DartLintRule {
  const AvoidWrappingInPadding() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_wrapping_in_padding',
    problemMessage:
        'Avoid wrapping a widget that has a padding property in a Padding widget.',
    correctionMessage: 'Use the padding property of the child widget instead.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      final type = node.staticType;
      if (type == null) return;
      if (type.element?.name != 'Padding') return;

      // Get 'child' argument
      Expression? childArg;
      for (final arg in node.argumentList.arguments) {
        if (arg is NamedExpression && arg.name.label.name == 'child') {
          childArg = arg.expression;
          break;
        }
      }

      if (childArg == null) return;

      // Check if child is an instance creation of a widget with padding property
      if (childArg is InstanceCreationExpression) {
        final childType = childArg.staticType;
        if (childType == null) return;

        // We can check known widgets or check if the constructor has 'padding' parameter.
        // Checking constructor parameter is more robust.
        final constructorElement = childArg.constructorName.element;
        if (constructorElement != null) {
          final hasPaddingParam = constructorElement.formalParameters.any(
            (p) => p.name == 'padding',
          );
          if (hasPaddingParam) {
            reporter.atNode(node, _code);
          }
        }
      }
    });
  }
}
