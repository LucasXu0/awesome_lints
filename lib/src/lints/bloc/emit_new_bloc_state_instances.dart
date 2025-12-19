import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class EmitNewBlocStateInstances extends DartLintRule {
  const EmitNewBlocStateInstances() : super(code: _code);

  static const _code = LintCode(
    name: 'emit_new_bloc_state_instances',
    problemMessage:
        'Avoid emitting the existing state instance. Create a new instance instead.',
    correctionMessage:
        'Use copyWith() or create a new state instance instead of emitting the existing state.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodInvocation((node) {
      if (node.methodName.name != 'emit') return;

      final arguments = node.argumentList.arguments;
      if (arguments.isEmpty) return;

      final argument = arguments.first;

      // Check if emitting 'state' directly (existing state instance)
      if (argument is SimpleIdentifier && argument.name == 'state') {
        reporter.atNode(argument, _code);
      }
    });
  }
}
