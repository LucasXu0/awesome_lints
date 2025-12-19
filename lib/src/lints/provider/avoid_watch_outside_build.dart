import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

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
    AstNode? current = node;
    bool foundFunctionExpression = false;

    while (current != null) {
      // If we encounter a function expression (callback), we're outside the direct build body
      if (current is FunctionExpression) {
        foundFunctionExpression = true;
      }

      if (current is MethodDeclaration) {
        // Check if this is a build method
        if (current.name.lexeme == 'build') {
          // Verify it returns Widget and has BuildContext parameter
          final parameters = current.parameters;
          if (parameters != null && parameters.parameters.isNotEmpty) {
            final firstParam = parameters.parameters.first;
            if (firstParam is SimpleFormalParameter) {
              final paramType = firstParam.type;
              if (paramType is NamedType &&
                  paramType.name.lexeme == 'BuildContext') {
                // If we found a function expression between the call and build method,
                // it means we're in a callback, so we're not directly in build
                return !foundFunctionExpression;
              }
            }
          }
        }
        return false;
      }
      current = current.parent;
    }

    return false;
  }
}
