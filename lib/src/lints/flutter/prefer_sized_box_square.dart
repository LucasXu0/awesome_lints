import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferSizedBoxSquare extends DartLintRule {
  const PreferSizedBoxSquare() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_sized_box_square',
    problemMessage: 'Use SizedBox.square when height and width are identical.',
    correctionMessage:
        'Consider using SizedBox.square(dimension: value) instead of SizedBox(height: value, width: value).',
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

      final typeName = type.getDisplayString();

      // Check if it's a SizedBox
      if (typeName != 'SizedBox') return;

      // Skip if it's already using SizedBox.square
      if (node.constructorName.name?.name == 'square') return;

      // Find the 'height' and 'width' arguments
      NamedExpression? heightArg;
      NamedExpression? widthArg;

      for (final arg
          in node.argumentList.arguments.whereType<NamedExpression>()) {
        if (arg.name.label.name == 'height') {
          heightArg = arg;
        } else if (arg.name.label.name == 'width') {
          widthArg = arg;
        }
      }

      // Both height and width must be present
      if (heightArg == null || widthArg == null) return;

      // Check if the values are identical
      final heightSource = heightArg.expression.toSource();
      final widthSource = widthArg.expression.toSource();

      if (heightSource == widthSource) {
        // Report the issue
        reporter.atNode(node, _code);
      }
    });
  }
}
