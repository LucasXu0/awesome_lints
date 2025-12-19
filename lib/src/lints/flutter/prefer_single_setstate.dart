import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferSingleSetstate extends DartLintRule {
  const PreferSingleSetstate() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_single_setstate',
    problemMessage:
        'Combine multiple consecutive setState calls into a single call. Multiple setState calls can cause unnecessary rebuilds.',
    correctionMessage:
        'Merge the consecutive setState calls into a single setState call.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodDeclaration((node) {
      final body = node.body;

      // Only check methods with block bodies
      if (body is! BlockFunctionBody) return;

      // Visit the method body to find consecutive setState calls
      final visitor = _ConsecutiveSetStateVisitor();
      visitor.visitBlock(body.block);

      // Report each consecutive setState call after the first one
      for (final setStateNode in visitor.consecutiveSetStateCalls) {
        reporter.atNode(setStateNode, _code);
      }
    });
  }
}

/// Visitor to detect consecutive setState calls in method bodies
class _ConsecutiveSetStateVisitor extends RecursiveAstVisitor<void> {
  final List<MethodInvocation> consecutiveSetStateCalls = [];
  MethodInvocation? _lastSetStateCall;

  @override
  void visitBlock(Block node) {
    // Save the previous setState tracking state
    final previousSetState = _lastSetStateCall;

    // Track setState calls in this block
    final statements = node.statements;

    for (var i = 0; i < statements.length; i++) {
      final statement = statements[i];

      // Check if this statement is a setState call
      final setStateCall = _extractSetStateCall(statement);

      if (setStateCall != null) {
        // If we have a previous setState call, this is a consecutive call
        if (_lastSetStateCall != null) {
          // Add to consecutive list (but not the first one)
          consecutiveSetStateCalls.add(setStateCall);
        }
        _lastSetStateCall = setStateCall;
      } else {
        // Not a setState call - check if it's a nested block
        if (statement is Block) {
          // Reset tracking before visiting nested block
          _lastSetStateCall = null;
          visitBlock(statement);
        } else if (_containsControlFlow(statement)) {
          // Reset tracking before visiting control flow
          _lastSetStateCall = null;
          statement.visitChildren(this);
        } else {
          // Regular statement between setState calls - reset tracking
          _lastSetStateCall = null;
        }
      }
    }

    // Restore the previous setState state
    _lastSetStateCall = previousSetState;
  }

  /// Check if a statement contains control flow structures
  bool _containsControlFlow(Statement statement) {
    return statement is IfStatement ||
        statement is ForStatement ||
        statement is WhileStatement ||
        statement is DoStatement ||
        statement is SwitchStatement ||
        statement is TryStatement ||
        statement is Block;
  }

  /// Extracts a setState call from a statement if it exists
  MethodInvocation? _extractSetStateCall(Statement statement) {
    // Handle expression statements
    if (statement is ExpressionStatement) {
      final expression = statement.expression;
      if (expression is MethodInvocation) {
        if (expression.methodName.name == 'setState') {
          return expression;
        }
      }
    }

    return null;
  }
}
