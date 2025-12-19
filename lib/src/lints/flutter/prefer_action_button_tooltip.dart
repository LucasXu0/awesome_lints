import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferActionButtonTooltip extends DartLintRule {
  const PreferActionButtonTooltip() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_action_button_tooltip',
    problemMessage: 'Add tooltip to action buttons for accessibility.',
    correctionMessage:
        'Add a tooltip parameter to improve accessibility for users.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  static const _actionButtonTypes = {'IconButton', 'FloatingActionButton'};

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      final type = node.staticType;
      if (type == null) return;

      // Check if it is an action button widget
      final typeName = type.element?.name;
      if (typeName == null || !_actionButtonTypes.contains(typeName)) return;

      // Check if tooltip parameter is present
      final hasTooltip = node.argumentList.arguments.any((arg) {
        if (arg is NamedExpression) {
          final name = arg.name.label.name;
          return name == 'tooltip';
        }
        return false;
      });

      if (!hasTooltip) {
        reporter.atNode(node, _code);
      }
    });
  }
}
