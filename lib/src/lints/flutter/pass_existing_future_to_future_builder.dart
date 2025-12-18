import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PassExistingFutureToFutureBuilder extends DartLintRule {
  const PassExistingFutureToFutureBuilder() : super(code: _code);

  static const _code = LintCode(
    name: 'pass_existing_future_to_future_builder',
    problemMessage:
        'Avoid creating futures inline in FutureBuilder. Create the future beforehand (e.g., in initState).',
    correctionMessage:
        'Create the future in initState or didUpdateWidget and assign it to a field, then pass that field to FutureBuilder.',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      final type = node.staticType;
      if (type == null) return;

      final typeName = type.getDisplayString();

      // Check if it's a FutureBuilder
      if (!typeName.startsWith('FutureBuilder')) return;

      // Find the 'future' argument
      NamedExpression? futureArg;
      try {
        futureArg =
            node.argumentList.arguments.whereType<NamedExpression>().firstWhere(
                  (arg) => arg.name.label.name == 'future',
                );
      } catch (_) {
        // No future argument found, skip
        return;
      }

      final expression = futureArg.expression;

      // Check if the future is being created inline
      // This includes:
      // 1. Method invocations (e.g., getValue(), Future.delayed(...))
      // 2. Function invocations
      // 3. Instance creation expressions (e.g., Future.value(...))

      if (expression is MethodInvocation) {
        // This covers cases like:
        // - getValue()
        // - Future.delayed(...)
        // - someObject.getFuture()
        reporter.atNode(
          node, // Report on the FutureBuilder instance creation node
          _code,
        );
      } else if (expression is FunctionExpressionInvocation) {
        // This covers cases where a function variable is called
        reporter.atNode(
          node, // Report on the FutureBuilder instance creation node
          _code,
        );
      } else if (expression is InstanceCreationExpression) {
        // This covers cases like:
        // - Future.value(...)
        // - Future.error(...)
        // Note: We need to check if it's actually a Future being created
        final creationType = expression.staticType;
        if (creationType != null) {
          final typeString = creationType.getDisplayString();
          if (typeString.startsWith('Future')) {
            reporter.atNode(
              node, // Report on the FutureBuilder instance creation node
              _code,
            );
          }
        }
      }
      // If it's just a simple identifier (variable/field reference) or
      // property access (widget.future), don't report
    });
  }
}
