import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferContainer extends DartLintRule {
  const PreferContainer() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_container',
    problemMessage:
        'Consider using a single Container instead of nested widgets.',
    correctionMessage: 'Replace the nested sequence with a Container widget.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  static const _minSequence = 3;

  // Widgets that can be replaced by Container properties
  static const _containerizableWidgets = {
    'Align', // alignment property
    'Padding', // padding property
    'DecoratedBox', // decoration property
    'Transform', // transform property
    'ConstrainedBox', // constraints property
    'SizedBox', // width, height properties
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

      // Check if this widget can be containerized
      if (!_containerizableWidgets.contains(typeName)) return;

      // Count the depth of containerizable widgets
      final depth = _countContainerizableDepth(node);

      if (depth < _minSequence) return;

      // Report the issue
      reporter.atNode(node, _code);
    });
  }

  int _countContainerizableDepth(InstanceCreationExpression node) {
    var depth = 0;
    InstanceCreationExpression? current = node;

    while (current != null) {
      final typeName = current.staticType?.element?.name;
      if (typeName == null || !_containerizableWidgets.contains(typeName)) {
        break;
      }

      depth++;

      // Find the child argument
      Expression? childExpr;
      for (final arg in current.argumentList.arguments) {
        if (arg is NamedExpression && arg.name.label.name == 'child') {
          childExpr = arg.expression;
          break;
        }
      }

      // Check if the child is also a containerizable widget
      if (childExpr is InstanceCreationExpression) {
        current = childExpr;
      } else {
        break;
      }
    }

    return depth;
  }
}
