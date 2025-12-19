import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class NoEqualNestedConditions extends DartLintRule {
  const NoEqualNestedConditions() : super(code: _code);

  static const _code = LintCode(
    name: 'no_equal_nested_conditions',
    problemMessage:
        'Nested if statement has the same condition as the parent if statement.',
    correctionMessage:
        'Remove the redundant nested condition or use a different condition.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addIfStatement((node) {
      final condition = node.expression.toString();

      // Visit the then statement to find nested if statements
      final visitor = _NestedIfVisitor(condition, reporter);
      node.thenStatement.visitChildren(visitor);
    });
  }
}

class _NestedIfVisitor extends RecursiveAstVisitor<void> {
  _NestedIfVisitor(this.parentCondition, this.reporter);

  final String parentCondition;
  final DiagnosticReporter reporter;

  @override
  void visitIfStatement(IfStatement node) {
    final nestedCondition = node.expression.toString();

    if (nestedCondition == parentCondition) {
      reporter.atNode(node.expression, NoEqualNestedConditions._code);
    }

    // Continue visiting nested statements
    super.visitIfStatement(node);
  }
}
