import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferConstrainedBoxOverContainer extends DartLintRule {
  const PreferConstrainedBoxOverContainer() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_constrained_box_over_container',
    problemMessage:
        'Prefer ConstrainedBox over Container when only constraints are needed.',
    correctionMessage:
        'Replace Container with ConstrainedBox for better performance.',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  // Container properties that make it inappropriate to convert to ConstrainedBox
  static const _disallowedProperties = {
    'margin',
    'padding',
    'color',
    'decoration',
    'foregroundDecoration',
    'transform',
    'transformAlignment',
    'clipBehavior',
    'alignment',
    'width',
    'height',
  };

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      final type = node.staticType;
      if (type == null) return;

      final typeName = type.element3?.name3;
      if (typeName != 'Container') return;

      // Extract named arguments
      final namedArgs =
          node.argumentList.arguments.whereType<NamedExpression>();

      // Check if constraints argument exists
      final hasConstraints =
          namedArgs.any((arg) => arg.name.label.name == 'constraints');

      if (!hasConstraints) return;

      // Check that only allowed properties are present
      final hasDisallowedProperties = namedArgs.any((arg) {
        final name = arg.name.label.name;
        return _disallowedProperties.contains(name);
      });

      if (hasDisallowedProperties) return;

      // Valid to replace with ConstrainedBox
      reporter.atNode(node, _code);
    });
  }

  @override
  List<Fix> getFixes() => [_ReplaceContainerWithConstrainedBox()];
}

class _ReplaceContainerWithConstrainedBox extends DartFix {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    analyzer_error.AnalysisError analysisError,
    List<analyzer_error.AnalysisError> others,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      if (!analysisError.sourceRange.intersects(node.sourceRange)) return;

      final type = node.staticType;
      if (type == null) return;

      final typeName = type.element3?.name3;
      if (typeName != 'Container') return;

      // Extract named arguments
      final namedArgs =
          node.argumentList.arguments.whereType<NamedExpression>();

      // Find constraints argument
      final constraintsArg = namedArgs
          .where((arg) => arg.name.label.name == 'constraints')
          .firstOrNull;

      if (constraintsArg == null) return;

      // Find child argument
      final childArg =
          namedArgs.where((arg) => arg.name.label.name == 'child').firstOrNull;

      // Find key argument
      final keyArg =
          namedArgs.where((arg) => arg.name.label.name == 'key').firstOrNull;

      // Build replacement code
      final buffer = StringBuffer('ConstrainedBox(');
      final args = <String>[];

      if (keyArg != null) {
        args.add('key: ${keyArg.expression.toSource()}');
      }

      args.add('constraints: ${constraintsArg.expression.toSource()}');

      if (childArg != null) {
        args.add('child: ${childArg.expression.toSource()}');
      }

      buffer.write(args.join(', '));
      buffer.write(')');

      final changeBuilder = reporter.createChangeBuilder(
        message: 'Replace Container with ConstrainedBox',
        priority: 80,
      );

      changeBuilder.addDartFileEdit((builder) {
        builder.addSimpleReplacement(
          node.sourceRange,
          buffer.toString(),
        );
      });
    });
  }
}
