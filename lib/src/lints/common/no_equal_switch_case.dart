import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class NoEqualSwitchCase extends DartLintRule {
  const NoEqualSwitchCase() : super(code: _code);

  static const _code = LintCode(
    name: 'no_equal_switch_case',
    problemMessage:
        'This switch case has the same body as a previous case. Consider combining them.',
    correctionMessage:
        'Combine cases with identical bodies using fall-through syntax.',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addSwitchStatement((node) {
      final caseBodies = <String, SwitchMember>{};

      for (final member in node.members) {
        // Skip default cases and empty cases
        if (member is! SwitchCase) continue;

        final statements = member.statements;
        if (statements.isEmpty) continue;

        // Get the body of the case (all statements as a string)
        final body = statements.map((s) => s.toString()).join();

        // Check if we've seen this body before
        if (caseBodies.containsKey(body)) {
          // Report on the duplicate case
          reporter.atNode(
            member,
            _code,
          );
        } else {
          // Store this body for future comparison
          caseBodies[body] = member;
        }
      }
    });
  }
}
