import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/diagnostic/diagnostic.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferAlignOverContainer extends DartLintRule {
  const PreferAlignOverContainer() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_align_over_container',
    problemMessage:
        'Prefer using Align instead of Container when only alignment is needed.',
    correctionMessage:
        'Replace Container with Align for alignment-only scenarios.',
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

      // Check if there's an alignment argument
      final hasAlignment = namedArgs.any(
        (arg) => arg.name.label.name == 'alignment',
      );
      if (!hasAlignment) return;

      // Check if there are other arguments besides alignment and child
      // Container is acceptable if it has other properties
      final otherArgs = namedArgs.where((arg) {
        final name = arg.name.label.name;
        return name != 'alignment' && name != 'child';
      });

      if (otherArgs.isNotEmpty) return;

      // Only alignment (and optionally child) - should use Align instead
      reporter.atNode(node, _code);
    });
  }

  @override
  List<Fix> getFixes() => [_ReplaceWithAlign()];
}

class _ReplaceWithAlign extends DartFix {
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

      // Find alignment and child arguments
      NamedExpression? alignmentArg;
      NamedExpression? childArg;

      for (final arg in namedArgs) {
        final name = arg.name.label.name;
        if (name == 'alignment') {
          alignmentArg = arg;
        } else if (name == 'child') {
          childArg = arg;
        }
      }

      if (alignmentArg == null) return;

      // Store final references for use in closure
      final finalAlignmentArg = alignmentArg;
      final finalChildArg = childArg;

      final changeBuilder = reporter.createChangeBuilder(
        message: 'Replace Container with Align',
        priority: 80,
      );

      changeBuilder.addDartFileEdit((builder) {
        // Build the Align widget
        final alignmentValue = finalAlignmentArg.expression.toSource();
        final childValue = finalChildArg?.expression.toSource();

        final alignWidget = childValue != null
            ? 'Align(\n  alignment: $alignmentValue,\n  child: $childValue,\n)'
            : 'Align(\n  alignment: $alignmentValue,\n)';

        builder.addSimpleReplacement(node.sourceRange, alignWidget);
      });
    });
  }
}
