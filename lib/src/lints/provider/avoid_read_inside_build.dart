import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import '../../utils/ast_extensions.dart';

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

    return paramType.name.lexeme == 'BuildContext';
  }
}
