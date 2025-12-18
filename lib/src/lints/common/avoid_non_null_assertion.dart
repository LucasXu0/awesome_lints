import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidNonNullAssertion extends DartLintRule {
  const AvoidNonNullAssertion() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_non_null_assertion',
    problemMessage:
        'Avoid using the non-null assertion operator (!) as it can cause runtime exceptions.',
    correctionMessage:
        'Use null-aware operators (?., ??) or proper null checks instead.',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  bool _isMapIndexOperation(PostfixExpression node) {
    // Check if the operand is an IndexExpression
    if (node.operand is! IndexExpression) {
      return false;
    }

    final indexExpr = node.operand as IndexExpression;
    final targetType = indexExpr.target?.staticType;

    // Check if the target is a Map type
    if (targetType != null && targetType.isDartCoreMap) {
      return true;
    }

    return false;
  }

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addPostfixExpression((node) {
      // Check if the operator is the null assertion operator (!)
      if (node.operator.type != TokenType.BANG) {
        return;
      }

      // Exclude Map index operations (e.g., map['key']!)
      // This is considered idiomatic in Dart
      if (_isMapIndexOperation(node)) {
        return;
      }

      reporter.atToken(
        node.operator,
        _code,
      );
    });
  }
}
