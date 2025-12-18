import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferTextRich extends DartLintRule {
  const PreferTextRich() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_text_rich',
    problemMessage:
        'Prefer Text.rich() over RichText() for better integration with DefaultTextStyle.',
    correctionMessage:
        'Replace RichText() with Text.rich() for automatic style inheritance and better Material integration.',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      final type = node.staticType;
      if (type == null) return;

      // Check if it's a RichText widget
      final typeName = type.element3?.name3;
      if (typeName != 'RichText') return;

      // Check if it's using the default constructor
      // RichText doesn't have named constructors, so any RichText() should be reported
      final constructorName = node.constructorName.name?.name;
      if (constructorName != null) {
        // If there's a named constructor, skip (though RichText doesn't have any)
        return;
      }

      // Report: RichText should be replaced with Text.rich
      // Text.rich provides better integration with DefaultTextStyle and Material theming
      reporter.atNode(node, _code);
    });
  }
}
