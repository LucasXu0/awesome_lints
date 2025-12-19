import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferSpacing extends DartLintRule {
  const PreferSpacing() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_spacing',
    problemMessage:
        'Prefer using the "spacing" parameter instead of inserting SizedBox widgets for spacing.',
    correctionMessage:
        'Use the "spacing" parameter available in Row, Column, and Flex widgets (Flutter 3.27+).',
    errorSeverity: analyzer_error.DiagnosticSeverity.INFO,
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

      // Check if it's a Column, Row, or Flex
      if (typeName != 'Column' && typeName != 'Row' && typeName != 'Flex') {
        return;
      }

      // Find the 'children' argument
      NamedExpression? childrenArg;
      try {
        childrenArg = node.argumentList.arguments
            .whereType<NamedExpression>()
            .firstWhere((arg) => arg.name.label.name == 'children');
      } catch (_) {
        return;
      }

      // Check if the widget already has a spacing parameter
      final hasSpacing = node.argumentList.arguments
          .whereType<NamedExpression>()
          .any((arg) => arg.name.label.name == 'spacing');

      // If spacing is already used, no need to suggest it
      if (hasSpacing) return;

      // Check if children is a list literal
      final expression = childrenArg.expression;
      if (expression is! ListLiteral) return;

      // Check if any children are spacing SizedBoxes
      bool hasSizedBoxSpacing = false;

      for (final element in expression.elements) {
        if (element is InstanceCreationExpression) {
          if (_isSpacingSizedBox(element, typeName)) {
            hasSizedBoxSpacing = true;
            break;
          }
        }
      }

      if (hasSizedBoxSpacing) {
        reporter.atNode(node, _code);
      }
    });
  }

  bool _isSpacingSizedBox(InstanceCreationExpression node, String parentType) {
    final type = node.staticType;
    if (type == null) return false;

    final typeName = type.getDisplayString();
    if (typeName != 'SizedBox') return false;

    // Check the arguments of the SizedBox
    final args = node.argumentList.arguments.whereType<NamedExpression>();

    bool hasWidth = false;
    bool hasHeight = false;
    bool hasChild = false;

    for (final arg in args) {
      final name = arg.name.label.name;
      if (name == 'width') hasWidth = true;
      if (name == 'height') hasHeight = true;
      if (name == 'child') hasChild = true;
    }

    // A spacing SizedBox typically has:
    // - For Column: only height, no child
    // - For Row: only width, no child
    // - For Flex: could be either

    // If it has a child, it's not just for spacing
    if (hasChild) return false;

    // For Column, check for height-only SizedBox
    if (parentType == 'Column' && hasHeight && !hasWidth) return true;

    // For Row, check for width-only SizedBox
    if (parentType == 'Row' && hasWidth && !hasHeight) return true;

    // For Flex, accept either
    if (parentType == 'Flex' && (hasWidth || hasHeight)) return true;

    return false;
  }
}
