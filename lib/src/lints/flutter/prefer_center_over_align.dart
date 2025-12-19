import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/diagnostic/diagnostic.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferCenterOverAlign extends DartLintRule {
  const PreferCenterOverAlign() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_center_over_align',
    problemMessage:
        'Prefer Center widget for centered alignment instead of Align.',
    correctionMessage: 'Replace Align with Center for better semantic clarity.',
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

      final typeName = type.element?.name;
      if (typeName != 'Align') return;

      // Extract named arguments
      final namedArgs = node.argumentList.arguments
          .whereType<NamedExpression>();

      // Find alignment argument
      final alignmentArg = namedArgs
          .where((arg) => arg.name.label.name == 'alignment')
          .firstOrNull;

      // Check if alignment is centered
      final isCentered = _isCenteredAlignment(alignmentArg);

      if (!isCentered) return;

      // Check that there are no other properties besides alignment, child, and key
      // Properties like widthFactor, heightFactor make Align different from Center
      final allowedProperties = {'alignment', 'child', 'key'};
      final hasDisallowedProperties = namedArgs.any((arg) {
        final name = arg.name.label.name;
        return !allowedProperties.contains(name);
      });

      if (hasDisallowedProperties) return;

      reporter.atNode(node, _code);
    });
  }

  bool _isCenteredAlignment(NamedExpression? alignmentArg) {
    if (alignmentArg == null) {
      // No alignment specified means default Alignment.center
      return true;
    }

    final expression = alignmentArg.expression;
    final source = expression.toSource();

    // Check for Alignment.center
    if (source == 'Alignment.center') return true;

    // Check for Alignment(0, 0) or Alignment(0.0, 0.0)
    if (expression is InstanceCreationExpression) {
      final typeName = expression.staticType?.element?.name;
      if (typeName == 'Alignment') {
        final args = expression.argumentList.arguments;
        if (args.length == 2) {
          final first = args[0].toSource();
          final second = args[1].toSource();
          if ((first == '0' || first == '0.0') &&
              (second == '0' || second == '0.0')) {
            return true;
          }
        }
      }
    }

    return false;
  }

  @override
  List<Fix> getFixes() => [_ReplaceAlignWithCenter()];
}

class _ReplaceAlignWithCenter extends DartFix {
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

      final typeName = type.element?.name;
      if (typeName != 'Align') return;

      // Extract named arguments
      final namedArgs = node.argumentList.arguments
          .whereType<NamedExpression>();

      // Find child argument
      final childArg = namedArgs
          .where((arg) => arg.name.label.name == 'child')
          .firstOrNull;

      // Find key argument
      final keyArg = namedArgs
          .where((arg) => arg.name.label.name == 'key')
          .firstOrNull;

      // Build replacement code
      final buffer = StringBuffer('Center(');
      final args = <String>[];

      if (keyArg != null) {
        args.add('key: ${keyArg.expression.toSource()}');
      }

      if (childArg != null) {
        args.add('child: ${childArg.expression.toSource()}');
      }

      buffer.write(args.join(', '));
      buffer.write(')');

      final changeBuilder = reporter.createChangeBuilder(
        message: 'Replace Align with Center',
        priority: 80,
      );

      changeBuilder.addDartFileEdit((builder) {
        builder.addSimpleReplacement(node.sourceRange, buffer.toString());
      });
    });
  }
}
