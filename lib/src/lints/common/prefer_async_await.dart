import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferAsyncAwait extends DartLintRule {
  const PreferAsyncAwait() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_async_await',
    problemMessage: 'Prefer async/await over .then() for handling Futures.',
    correctionMessage:
        'Use async/await instead of .then() for clearer code and to avoid subtle bugs when mixing await with .then().',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodInvocation((node) {
      // Check if the method name is 'then'
      if (node.methodName.name != 'then') return;

      // Check if the target is a Future
      final target = node.realTarget;
      if (target == null) return;

      final targetType = target.staticType;
      if (targetType == null) return;

      if (_isFutureType(targetType)) {
        reporter.atNode(node.methodName, _code);
      }
    });
  }

  bool _isFutureType(DartType type) {
    final element = type.element;
    if (element == null) return false;

    // Check if it's a Future or FutureOr
    final name = element.displayName;
    return name == 'Future' || name == 'FutureOr';
  }
}
