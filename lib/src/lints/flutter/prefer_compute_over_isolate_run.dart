import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferComputeOverIsolateRun extends DartLintRule {
  const PreferComputeOverIsolateRun() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_compute_over_isolate_run',
    problemMessage:
        'Use compute() instead of Isolate.run() in Flutter for better integration.',
    correctionMessage:
        'Replace Isolate.run() with Flutter\'s compute() function for better integration with the framework and automatic error handling.',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodInvocation((node) {
      // Check if it's a run method call
      final methodName = node.methodName.name;
      if (methodName != 'run') return;

      // Check if the target is Isolate or a prefix.Isolate
      final target = node.target;
      if (target == null) return;

      bool isIsolateTarget = false;

      if (target is SimpleIdentifier) {
        // Case: Isolate.run()
        isIsolateTarget = target.name == 'Isolate';
      } else if (target is PrefixedIdentifier) {
        // Case: import 'dart:isolate' as prefix; prefix.Isolate.run()
        isIsolateTarget = target.identifier.name == 'Isolate';
      }

      if (isIsolateTarget) {
        // Report the issue
        reporter.atNode(
          node,
          _code,
        );
      }
    });
  }
}
