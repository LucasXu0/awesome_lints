import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidEmptySetstate extends DartLintRule {
  const AvoidEmptySetstate() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_empty_setstate',
    problemMessage:
        'Avoid calling setState with an empty callback. Empty setState still triggers a re-render but is usually a bug.',
    correctionMessage:
        'Add state changes inside the setState callback or remove the setState call.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodInvocation((node) {
      // Check if it's a setState call
      if (node.methodName.name != 'setState') return;

      // Get the callback argument
      final arguments = node.argumentList.arguments;
      if (arguments.isEmpty) return;

      final callback = arguments.first;

      // Check if callback is a function expression or closure
      if (callback is! FunctionExpression) return;

      final functionBody = callback.body;

      // Check if the function body is empty
      if (_isEmptyBody(functionBody)) {
        reporter.atNode(node, _code);
      }
    });
  }

  /// Check if a function body is empty or contains only a null expression
  bool _isEmptyBody(FunctionBody body) {
    if (body is BlockFunctionBody) {
      // Block body like: () {}
      final block = body.block;
      return block.statements.isEmpty;
    } else if (body is ExpressionFunctionBody) {
      // Expression body like: () => null
      final expression = body.expression;

      // Check if it's a null literal
      if (expression is NullLiteral) {
        return true;
      }

      // Not empty if it has any other expression
      return false;
    }

    return false;
  }
}
