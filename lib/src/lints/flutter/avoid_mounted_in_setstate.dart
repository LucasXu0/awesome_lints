import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidMountedInSetstate extends DartLintRule {
  const AvoidMountedInSetstate() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_mounted_in_setstate',
    problemMessage:
        'Avoid checking mounted inside setState callback. Check mounted before calling setState instead.',
    correctionMessage: 'Move the mounted check before the setState call.',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodInvocation((node) {
      // Check if it's a setState call
      if (node.methodName.name != 'setState') return;

      // Get the callback argument
      final arguments = node.argumentList.arguments;
      if (arguments.isEmpty) return;

      final callback = arguments.first;

      // Check if callback is a function expression or closure
      if (callback is! FunctionExpression) return;

      final functionBody = callback.body;

      // Visit the function body to find mounted checks
      final visitor = _MountedCheckVisitor();
      functionBody.visitChildren(visitor);

      if (visitor.hasMountedCheck) {
        reporter.atNode(
          node,
          _code,
        );
      }
    });
  }
}

/// Visitor to detect mounted checks in the AST
class _MountedCheckVisitor extends RecursiveAstVisitor<void> {
  bool hasMountedCheck = false;

  @override
  void visitSimpleIdentifier(SimpleIdentifier node) {
    // Check for 'mounted' identifier
    if (node.name == 'mounted') {
      hasMountedCheck = true;
    }
    super.visitSimpleIdentifier(node);
  }

  @override
  void visitPrefixedIdentifier(PrefixedIdentifier node) {
    // Check for 'context.mounted'
    if (node.identifier.name == 'mounted') {
      hasMountedCheck = true;
    }
    super.visitPrefixedIdentifier(node);
  }

  @override
  void visitPropertyAccess(PropertyAccess node) {
    // Check for 'context.mounted' or similar property access
    if (node.propertyName.name == 'mounted') {
      hasMountedCheck = true;
    }
    super.visitPropertyAccess(node);
  }
}
