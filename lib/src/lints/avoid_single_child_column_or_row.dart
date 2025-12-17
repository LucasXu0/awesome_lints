import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidSingleChildColumnOrRow extends DartLintRule {
  const AvoidSingleChildColumnOrRow() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_single_child_column_or_row',
    problemMessage:
        'Avoid using Column or Row with a single child. Consider removing the wrapper.',
    correctionMessage:
        'Remove the Column/Row wrapper and use the child directly.',
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

      final typeName = type.getDisplayString();

      // Check if it's a Column or Row
      if (typeName != 'Column' && typeName != 'Row') return;

      // Find the 'children' argument
      NamedExpression? childrenArg;
      try {
        childrenArg =
            node.argumentList.arguments.whereType<NamedExpression>().firstWhere(
                  (arg) => arg.name.label.name == 'children',
                );
      } catch (_) {
        return;
      }

      // Check if children is a list literal
      final expression = childrenArg.expression;
      if (expression is! ListLiteral) return;

      // Check if the list has exactly one element
      if (expression.elements.length != 1) return;

      final singleElement = expression.elements.first;

      // Handle special cases that might produce multiple children
      if (singleElement is SpreadElement) {
        // Check if spreading a list literal
        final spreadExpression = singleElement.expression;
        if (spreadExpression is ListLiteral) {
          // Only trigger if the spread literal has exactly one element
          if (spreadExpression.elements.length != 1) return;
        } else {
          // Can't determine size of spread variable, skip to avoid false positives
          return;
        }
      } else if (singleElement is ForElement) {
        // Can't reliably determine loop iteration count, skip to avoid false positives
        return;
      } else if (singleElement is IfElement) {
        // Only trigger if it's an if-else where both branches produce exactly one child
        // Skip simple if statements (produces 0 or 1) to avoid false positives
        if (singleElement.elseElement == null) {
          return;
        }
      }

      // Report the issue
      reporter.atNode(
        node,
        _code,
      );
    });
  }

  @override
  List<Fix> getFixes() => [_RemoveSingleChildWrapper()];
}

class _RemoveSingleChildWrapper extends DartFix {
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

      final typeName = type.getDisplayString();
      if (typeName != 'Column' && typeName != 'Row') return;

      // Find the 'children' argument
      NamedExpression? childrenArg;
      try {
        childrenArg =
            node.argumentList.arguments.whereType<NamedExpression>().firstWhere(
                  (arg) => arg.name.label.name == 'children',
                );
      } catch (_) {
        return;
      }

      final expression = childrenArg.expression;
      if (expression is! ListLiteral) return;

      if (expression.elements.length != 1) return;

      final singleElement = expression.elements.first;

      // Handle special cases that might produce multiple children
      if (singleElement is SpreadElement) {
        // Check if spreading a list literal
        final spreadExpression = singleElement.expression;
        if (spreadExpression is ListLiteral) {
          // Only apply fix if the spread literal has exactly one element
          if (spreadExpression.elements.length != 1) return;
        } else {
          // Can't determine size of spread variable, skip to avoid incorrect fixes
          return;
        }
      } else if (singleElement is ForElement) {
        // Can't reliably determine loop iteration count, skip to avoid incorrect fixes
        return;
      } else if (singleElement is IfElement) {
        // Only apply fix if it's an if-else where both branches produce exactly one child
        // Skip simple if statements (produces 0 or 1) to avoid incorrect fixes
        if (singleElement.elseElement == null) {
          return;
        }
      }

      final singleChild = singleElement;

      final changeBuilder = reporter.createChangeBuilder(
        message: 'Remove $typeName wrapper',
        priority: 80,
      );

      changeBuilder.addDartFileEdit((builder) {
        builder.addSimpleReplacement(
          node.sourceRange,
          singleChild.toSource(),
        );
      });
    });
  }
}
