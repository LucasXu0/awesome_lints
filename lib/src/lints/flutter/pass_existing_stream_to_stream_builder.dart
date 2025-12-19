import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PassExistingStreamToStreamBuilder extends DartLintRule {
  const PassExistingStreamToStreamBuilder() : super(code: _code);

  static const _code = LintCode(
    name: 'pass_existing_stream_to_stream_builder',
    problemMessage:
        'Avoid creating streams inline in StreamBuilder. Create the stream beforehand (e.g., in initState).',
    correctionMessage:
        'Create the stream in initState or didUpdateWidget and assign it to a field, then pass that field to StreamBuilder.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      final type = node.staticType;
      if (type == null) return;

      final typeName = type.getDisplayString();

      // Check if it's a StreamBuilder
      if (!typeName.startsWith('StreamBuilder')) return;

      // Find the 'stream' argument
      NamedExpression? streamArg;
      try {
        streamArg = node.argumentList.arguments
            .whereType<NamedExpression>()
            .firstWhere((arg) => arg.name.label.name == 'stream');
      } catch (_) {
        // No stream argument found, skip
        return;
      }

      final expression = streamArg.expression;

      // Check if the stream is being created inline
      // This includes:
      // 1. Method invocations (e.g., getValue(), Stream.periodic(...))
      // 2. Function invocations
      // 3. Instance creation expressions (e.g., Stream.value(...))

      if (expression is MethodInvocation) {
        // This covers cases like:
        // - getValue()
        // - Stream.periodic(...)
        // - someObject.getStream()
        reporter.atNode(
          node, // Report on the StreamBuilder instance creation node
          _code,
        );
      } else if (expression is FunctionExpressionInvocation) {
        // This covers cases where a function variable is called
        reporter.atNode(
          node, // Report on the StreamBuilder instance creation node
          _code,
        );
      } else if (expression is InstanceCreationExpression) {
        // This covers cases like:
        // - Stream.value(...)
        // - Stream.error(...)
        // Note: We need to check if it's actually a Stream being created
        final creationType = expression.staticType;
        if (creationType != null) {
          final typeString = creationType.getDisplayString();
          if (typeString.startsWith('Stream')) {
            reporter.atNode(
              node, // Report on the StreamBuilder instance creation node
              _code,
            );
          }
        }
      }
      // If it's just a simple identifier (variable/field reference) or
      // property access (widget.stream), don't report
    });
  }
}
