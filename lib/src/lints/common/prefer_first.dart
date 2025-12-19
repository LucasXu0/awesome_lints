import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferFirst extends DartLintRule {
  const PreferFirst() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_first',
    problemMessage: 'Prefer using .first instead of [0] or .elementAt(0).',
    correctionMessage: 'Use .first for better readability.',
    errorSeverity: analyzer_error.DiagnosticSeverity.INFO,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addIndexExpression((node) {
      _checkIndexExpression(node, reporter);
    });

    context.registry.addMethodInvocation((node) {
      _checkElementAtInvocation(node, reporter);
    });
  }

  void _checkIndexExpression(
    IndexExpression node,
    DiagnosticReporter reporter,
  ) {
    final index = node.index;

    // Check if accessing [0]
    if (index is IntegerLiteral && index.value == 0) {
      reporter.atNode(node, _code);
    }
  }

  void _checkElementAtInvocation(
    MethodInvocation node,
    DiagnosticReporter reporter,
  ) {
    // Check if calling elementAt(0)
    if (node.methodName.name != 'elementAt') {
      return;
    }

    final arguments = node.argumentList.arguments;
    if (arguments.length != 1) {
      return;
    }

    final argument = arguments.first;
    if (argument is IntegerLiteral && argument.value == 0) {
      reporter.atNode(node, _code);
    }
  }
}
