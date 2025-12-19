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
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addCascadeExpression((node) {
      // Check if the target of the cascade is a binary expression with ??
      final target = node.target;

      // Check if target is directly a binary expression with ??
      BinaryExpression? binaryExpr;
      if (target is BinaryExpression &&
          target.operator.type == TokenType.QUESTION_QUESTION) {
        binaryExpr = target;
      }

      if (binaryExpr != null) {
        // The cascade is directly applied to an if-null expression
        // This is problematic as it may not work as expected
        reporter.atNode(binaryExpr, _code);
      }
    });

    // Also check for the pattern where a cascade is the right operand of ??
    // e.g., nullableCow ?? Cow()..moo() might parse as ?? with cascade on right
    context.registry.addBinaryExpression((node) {
      if (node.operator.type != TokenType.QUESTION_QUESTION) {
        return;
      }

      final rightOperand = node.rightOperand;
      if (rightOperand is CascadeExpression) {
        // The right side of ?? is a cascade expression
        // This is problematic as it may not work as expected
        reporter.atNode(node, _code);
      }
    });
  }
}
