import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidAsyncCallbackInFakeAsync extends DartLintRule {
  const AvoidAsyncCallbackInFakeAsync() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_async_callback_in_fake_async',
    problemMessage:
        'Async callbacks passed to FakeAsync are not awaited making the test to always pass.',
    correctionMessage: 'Remove the async keyword from the callback.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodInvocation((node) {
      if (!_isFakeAsyncMethod(node)) return;

      final arguments = node.argumentList.arguments;
      if (arguments.isEmpty) return;

      final callback = arguments.first;
      if (callback is! FunctionExpression) return;

      if (_isAsyncCallback(callback)) {
        reporter.atNode(node, _code);
      }
    });

    context.registry.addFunctionExpressionInvocation((node) {
      if (!_isFakeAsyncFunctionInvocation(node)) return;

      final arguments = node.argumentList.arguments;
      if (arguments.isEmpty) return;

      final callback = arguments.first;
      if (callback is! FunctionExpression) return;

      if (_isAsyncCallback(callback)) {
        reporter.atNode(node, _code);
      }
    });
  }

  bool _isFakeAsyncMethod(MethodInvocation node) {
    // Check for FakeAsync().run() or similar
    final methodName = node.methodName.name;
    if (methodName != 'run') return false;

    final target = node.target;
    if (target is InstanceCreationExpression) {
      final typeName = target.constructorName.type.name.lexeme;
      return typeName == 'FakeAsync';
    }

    return false;
  }

  bool _isFakeAsyncFunctionInvocation(FunctionExpressionInvocation node) {
    // Check for fakeAsync() function call
    final function = node.function;
    if (function is SimpleIdentifier && function.name == 'fakeAsync') {
      return true;
    }
    return false;
  }

  bool _isAsyncCallback(FunctionExpression callback) {
    return callback.body.isAsynchronous;
  }
}
