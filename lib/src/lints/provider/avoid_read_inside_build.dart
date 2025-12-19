import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidReadInsideBuild extends DartLintRule {
  const AvoidReadInsideBuild() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_read_inside_build',
    problemMessage:
        'Avoid using context.read() inside build methods. Use context.watch() instead for reactive updates.',
    correctionMessage:
        'Replace context.read() with context.watch() to ensure the widget rebuilds when the value changes.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodInvocation((node) {
      if (!_isReadMethod(node)) return;

      if (_isInsideBuildMethod(node)) {
        reporter.atNode(node, _code);
      }
    });
  }

  bool _isReadMethod(MethodInvocation node) {
    return node.methodName.name == 'read';
  }

  bool _isInsideBuildMethod(AstNode node) {
    AstNode? current = node;

    while (current != null) {
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
                return true;
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
