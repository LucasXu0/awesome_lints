import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferForLoopInChildren extends DartLintRule {
  const PreferForLoopInChildren() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_for_loop_in_children',
    problemMessage:
        'Prefer using for-loop instead of functional methods in children arguments.',
    correctionMessage:
        'Replace .map().toList(), List.generate(), or fold() with a for-loop.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      // Find 'children' argument
      for (final arg in node.argumentList.arguments) {
        if (arg is! NamedExpression) continue;
        if (arg.name.label.name != 'children') continue;

        final expression = arg.expression;

        // Check for direct functional method calls
        if (_isFunctionalListCreation(expression)) {
          reporter.atNode(node, _code);
          continue;
        }

        // Check inside list literals for spread elements with functional methods
        if (expression is ListLiteral) {
          for (final element in expression.elements) {
            if (element is SpreadElement) {
              if (_isFunctionalListCreation(element.expression)) {
                reporter.atNode(node, _code);
              }
            }
          }
        }
      }
    });
  }

  bool _isFunctionalListCreation(Expression expression) {
    // Check for .map(...).toList() pattern
    if (expression is MethodInvocation) {
      final methodName = expression.methodName.name;

      // Check for .toList() call
      if (methodName == 'toList') {
        final target = expression.target;
        if (target is MethodInvocation && target.methodName.name == 'map') {
          return true;
        }
      }

      // Check for List.generate()
      if (methodName == 'generate') {
        final target = expression.target;
        // Check if target is an identifier with name 'List'
        if (target != null) {
          final targetSource = target.toSource();
          if (targetSource == 'List') {
            return true;
          }
        }
      }

      // Check for .fold() accumulating into a list
      if (methodName == 'fold') {
        return true;
      }

      // Check for .map() without .toList() (though less common)
      if (methodName == 'map') {
        return true;
      }
    }

    return false;
  }
}
