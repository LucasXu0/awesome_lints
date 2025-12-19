import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidMissingController extends DartLintRule {
  const AvoidMissingController() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_missing_controller',
    problemMessage:
        'Changes to this field\'s value are not saved to your widget\'s state. '
        'Try providing a controller or listening to the value change events.',
    correctionMessage:
        'Add a TextEditingController or an onChanged callback to track input changes.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  static const _textInputWidgets = {
    'TextField',
    'TextFormField',
    'EditableText',
  };

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      final type = node.staticType;
      if (type == null) return;

      final typeName = type.element?.name;
      if (typeName == null) return;

      // Check if it's a text input widget
      if (!_textInputWidgets.contains(typeName)) return;

      // Get all named arguments
      final namedArgs = node.argumentList.arguments
          .whereType<NamedExpression>();

      // Check if there's a controller or onChanged callback
      final hasController = namedArgs.any(
        (arg) => arg.name.label.name == 'controller',
      );
      final hasOnChanged = namedArgs.any(
        (arg) => arg.name.label.name == 'onChanged',
      );
      final hasOnSaved = namedArgs.any(
        (arg) => arg.name.label.name == 'onSaved',
      );

      // If none of these are present, report the issue
      if (!hasController && !hasOnChanged && !hasOnSaved) {
        reporter.atNode(node, _code);
      }
    });
  }
}
