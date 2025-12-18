import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidDeclaringCallMethod extends DartLintRule {
  const AvoidDeclaringCallMethod() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_declaring_call_method',
    problemMessage:
        'Avoid implementing a call method. Use a named method instead.',
    correctionMessage:
        'Replace the call method with a descriptive method name for better clarity.',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodDeclaration((node) {
      final methodName = node.name.lexeme;
      if (methodName == 'call') {
        reporter.atNode(
          node,
          _code,
        );
      }
    });
  }
}
