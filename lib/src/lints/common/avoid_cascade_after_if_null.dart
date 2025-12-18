import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidCascadeAfterIfNull extends DartLintRule {
  const AvoidCascadeAfterIfNull() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_cascade_after_if_null',
    problemMessage:
        'Avoid using cascade expressions after if-null (??) operator without parentheses.',
    correctionMessage:
        'Add parentheses around the if-null expression to clarify the execution order: (expression ?? value)..method()',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addCascadeExpression((node) {
      // Check if the target of the cascade is a binary expression with ??
      final target = node.target;

      if (target is BinaryExpression &&
          target.operator.type == TokenType.QUESTION_QUESTION) {
        // The cascade is directly applied to an if-null expression
        // This is problematic as it may not work as expected
        reporter.atNode(
          node,
          _code,
        );
      }
    });
  }
}
