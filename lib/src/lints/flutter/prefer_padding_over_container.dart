import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/diagnostic/diagnostic.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferPaddingOverContainer extends DartLintRule {
  const PreferPaddingOverContainer() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_padding_over_container',
    problemMessage:
        'Prefer using Padding instead of Container when only padding or margin is needed.',
    correctionMessage:
        'Replace Container with Padding for padding-only scenarios.',
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
      if (type.element?.name != 'Container') return;

      // Get all named arguments
      final namedArgs = node.argumentList.arguments
          .whereType<NamedExpression>();

      // Check if there's a padding or margin argument
      final hasPadding = namedArgs.any(
        (arg) => arg.name.label.name == 'padding',
      );
      final hasMargin = namedArgs.any((arg) => arg.name.label.name == 'margin');

      if (!hasPadding && !hasMargin) return;

      // Check if there are other arguments besides padding/margin and child
      // Container is acceptable if it has other properties
      final otherArgs = namedArgs.where((arg) {
        final name = arg.name.label.name;
        return name != 'padding' &&
            name != 'margin' &&
            name != 'child' &&
            name != 'key';
      });

      if (otherArgs.isNotEmpty) return;

      // Only padding/margin (and optionally child/key) - should use Padding instead
      reporter.atNode(node, _code);
    });
  }

  @override
  List<Fix> getFixes() => [_ReplaceWithPadding()];
}

class _ReplaceWithPadding extends DartFix {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    Diagnostic analysisError,
    List<Diagnostic> others,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      if (!analysisError.sourceRange.intersects(node.sourceRange)) return;

      final type = node.staticType;
      if (type == null) return;
      if (type.element?.name != 'Container') return;

      final namedArgs = node.argumentList.arguments
          .whereType<NamedExpression>();

      // Find padding, margin, and child arguments
      NamedExpression? paddingArg;
      NamedExpression? marginArg;
      NamedExpression? childArg;
      NamedExpression? keyArg;

      for (final arg in namedArgs) {
        final name = arg.name.label.name;
        if (name == 'padding') {
          paddingArg = arg;
        } else if (name == 'margin') {
          marginArg = arg;
        } else if (name == 'child') {
          childArg = arg;
        } else if (name == 'key') {
          keyArg = arg;
        }
      }

      if (paddingArg == null && marginArg == null) return;

      // Store final references for use in closure
      final finalPaddingArg = paddingArg ?? marginArg;
      final finalChildArg = childArg;
      final finalKeyArg = keyArg;

      final changeBuilder = reporter.createChangeBuilder(
        message: 'Replace Container with Padding',
        priority: 80,
      );

      changeBuilder.addDartFileEdit((builder) {
        // Build the Padding widget
        final paddingValue = finalPaddingArg!.expression.toSource();
        final childValue = finalChildArg?.expression.toSource();
        final keyValue = finalKeyArg?.expression.toSource();

        final keyPart = keyValue != null ? 'key: $keyValue,\n  ' : '';
        final paddingWidget = childValue != null
            ? 'Padding(\n  ${keyPart}padding: $paddingValue,\n  child: $childValue,\n)'
            : 'Padding(\n  ${keyPart}padding: $paddingValue,\n)';

        builder.addSimpleReplacement(node.sourceRange, paddingWidget);
      });
    });
  }
}
