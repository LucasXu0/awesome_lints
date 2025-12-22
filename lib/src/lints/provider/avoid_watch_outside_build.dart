import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import '../../utils/ast_extensions.dart';

class AvoidWatchOutsideBuild extends DartLintRule {
  const AvoidWatchOutsideBuild() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_watch_outside_build',
    problemMessage:
        'Avoid using context.watch() or context.select() outside build methods. Use context.read() for one-time access.',
    correctionMessage:
        'Replace context.watch() or context.select() with context.read() when not inside a build method.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodInvocation((node) {
      if (!_isWatchOrSelectMethod(node)) return;

      if (!_isInsideBuildMethod(node)) {
        reporter.atNode(node, _code);
      }
    });
  }

  bool _isWatchOrSelectMethod(MethodInvocation node) {
    final methodName = node.methodName.name;
    return methodName == 'watch' || methodName == 'select';
  }

  bool _isInsideBuildMethod(AstNode node) {
    // Check if there's a FunctionExpression between node and build method
    final functionExpression = node.findAncestorOfType<FunctionExpression>();

    // Find enclosing method declaration
    final method = node.findAncestorOfType<MethodDeclaration>();
    if (method == null) return false;

    // Check if this is a build method
    if (method.name.lexeme != 'build') return false;

    // Verify it has BuildContext parameter
    final parameters = method.parameters;
    if (parameters == null || parameters.parameters.isEmpty) return false;

    final firstParam = parameters.parameters.first;
    if (firstParam is! SimpleFormalParameter) return false;

    final paramType = firstParam.type;
    if (paramType is! NamedType) return false;
    if (paramType.name.lexeme != 'BuildContext') return false;

    // If there's a function expression between the call and build method,
    // it means we're in a callback, so we're not directly in build
    if (functionExpression != null) {
      // Check if the function expression is between node and method
      final isBetween =
          functionExpression.findAncestorOfType<MethodDeclaration>() == method;
      if (isBetween) return false;
    }

    return true;
  }
}
