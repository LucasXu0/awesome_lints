import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import '../../utils/ast_extensions.dart';

class PreferReturnAwait extends DartLintRule {
  const PreferReturnAwait() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_return_await',
    problemMessage:
        'Returning a Future from a try block without await may cause exceptions to escape the catch handler.',
    correctionMessage:
        'Add await before returning the Future to ensure exceptions are caught.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addReturnStatement((node) {
      // Skip if there's no expression being returned
      if (node.expression == null) return;

      // Skip if the return is already awaited
      if (node.expression is AwaitExpression) return;

      // Check if we're in an async function
      if (!_isInAsyncFunction(node)) return;

      // Check if we're in a try block
      if (!_isInTryBlock(node)) return;

      // Check if the returned expression is a Future
      final expression = node.expression!;
      final type = expression.staticType;
      if (type == null) return;

      if (_isFutureType(type)) {
        reporter.atNode(node.expression!, _code);
      }
    });
  }

  bool _isInAsyncFunction(AstNode node) {
    // Find any enclosing function-like node
    final ancestor = node.findAncestor((n) {
      if (n is FunctionExpression) return true;
      if (n is MethodDeclaration) return true;
      if (n is FunctionDeclaration) return true;
      return false;
    });

    if (ancestor == null) return false;

    // Check if it's async
    if (ancestor is FunctionExpression) {
      return ancestor.body.isAsynchronous;
    }
    if (ancestor is MethodDeclaration) {
      return ancestor.body.isAsynchronous;
    }
    if (ancestor is FunctionDeclaration) {
      return ancestor.functionExpression.body.isAsynchronous;
    }

    return false;
  }

  bool _isInTryBlock(AstNode node) {
    AstNode? current = node.parent;
    while (current != null) {
      // Stop at function boundaries
      if (current is FunctionExpression ||
          current is MethodDeclaration ||
          current is FunctionDeclaration) {
        return false;
      }

      if (current is TryStatement) {
        // Check if we're in the try body (not in catch or finally)
        return current.body.statements.any((stmt) => stmt.contains(node));
      }

      current = current.parent;
    }
    return false;
  }

  bool _isFutureType(DartType type) {
    final element = type.element;
    if (element == null) return false;

    // Check if it's a Future or FutureOr
    final name = element.displayName;
    return name == 'Future' || name == 'FutureOr';
  }
}

extension _AstNodeExtension on AstNode {
  bool contains(AstNode other) {
    AstNode? current = other;
    while (current != null) {
      if (identical(current, this)) return true;
      current = current.parent;
    }
    return false;
  }
}
