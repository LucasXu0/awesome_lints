import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/diagnostic/diagnostic.dart';
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

  @override
  List<Fix> getFixes() => [_ReplaceWithFirst()];
}

class _ReplaceWithFirst extends DartFix {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    Diagnostic analysisError,
    List<Diagnostic> others,
  ) {
    context.registry.addIndexExpression((node) {
      if (!analysisError.sourceRange.intersects(node.sourceRange)) return;

      final index = node.index;
      if (index is IntegerLiteral && index.value == 0) {
        final changeBuilder = reporter.createChangeBuilder(
          message: 'Replace with .first',
          priority: 80,
        );

        changeBuilder.addDartFileEdit((builder) {
          // Replace [0] with .first
          final target = node.target;
          if (target != null) {
            builder.addSimpleReplacement(
              node.sourceRange,
              '${target.toSource()}.first',
            );
          }
        });
      }
    });

    context.registry.addMethodInvocation((node) {
      if (!analysisError.sourceRange.intersects(node.sourceRange)) return;

      if (node.methodName.name != 'elementAt') return;

      final arguments = node.argumentList.arguments;
      if (arguments.length != 1) return;

      final argument = arguments.first;
      if (argument is IntegerLiteral && argument.value == 0) {
        final changeBuilder = reporter.createChangeBuilder(
          message: 'Replace with .first',
          priority: 80,
        );

        changeBuilder.addDartFileEdit((builder) {
          // Replace .elementAt(0) with .first
          final target = node.target;
          if (target != null) {
            builder.addSimpleReplacement(
              node.sourceRange,
              '${target.toSource()}.first',
            );
          }
        });
      }
    });
  }
}
