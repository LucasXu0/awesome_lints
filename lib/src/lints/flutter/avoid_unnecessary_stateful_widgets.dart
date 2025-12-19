import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidUnnecessaryStatefulWidgets extends DartLintRule {
  const AvoidUnnecessaryStatefulWidgets() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_unnecessary_stateful_widgets',
    problemMessage: 'Avoid using StatefulWidget when the state is not used.',
    correctionMessage: 'Convert to StatelessWidget.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addClassDeclaration((node) {
      final element = node.declaredFragment?.element;
      if (element == null) return;

      // Check if it extends State
      // We are looking for the "State" class of the StatefulWidget.
      // Usually "class _MyWidgetState extends State<MyWidget>"

      // This is a simplified check. We need to check if it extends State.
      final superType = element.supertype;
      if (superType == null || superType.element.name != 'State') return;

      // Now check usage inside the class.
      // 1. Check if setState is used.
      // 2. Check if fields are non-final (mutable state).
      // 3. Check if lifecycle methods (initState, dispose, didUpdateWidget, etc.) are overridden.

      // If none of the above, it can be stateless.

      final visitor = _StateUsageVisitor();
      node.visitChildren(visitor);

      if (!visitor.hasSetState &&
          !visitor.hasMutableFields &&
          !visitor.hasLifecycleOverrides) {
        // We found a State class that doesn't seem to use State features.
        // We should report on the StatefulWidget, or the State class?
        // Usually the State class is where we look.

        reporter.atNode(node, _code);
      }
    });
  }
}

class _StateUsageVisitor extends RecursiveAstVisitor<void> {
  bool hasSetState = false;
  bool hasMutableFields = false;
  bool hasLifecycleOverrides = false;

  static const _lifecycleMethods = {
    'initState',
    'didUpdateWidget',
    'didChangeDependencies',
    'dispose',
    'deactivate',
    'reassemble',
  };

  @override
  void visitMethodInvocation(MethodInvocation node) {
    if (node.methodName.name == 'setState') {
      hasSetState = true;
    }
    super.visitMethodInvocation(node);
  }

  @override
  void visitFieldDeclaration(FieldDeclaration node) {
    // If any field is not final, it's mutable state.
    // However, sometimes people use late final fields initialized in initState.
    // If it's final, it's technically immutable, but if it is late, it might be state-related.
    // But basic rule: if you have fields in State, you probably need State.
    // Unless they are just constants?
    // Let's say if there are ANY fields, we assume it's stateful for now to be safe?
    // DCM rule says "Avoid using StatefulWidget when the state is not used."
    // If I have `final int x = 1;` in State, it's weird (should be in Widget), but maybe not "state".
    // But if I have `int x = 0;`, it is state.

    // Let's check for non-final fields.
    if (!node.fields.isFinal && !node.fields.isConst) {
      hasMutableFields = true;
    }

    // Even if they are final, if they are not static, they are instance fields of State.
    // State is long-lived. If you store something in State, you are using State.
    // So ANY instance field in State class implies statefulness (data persistence across builds).
    if (!node.isStatic) {
      hasMutableFields = true;
    }

    super.visitFieldDeclaration(node);
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    if (_lifecycleMethods.contains(node.name.lexeme)) {
      hasLifecycleOverrides = true;
    }
    super.visitMethodDeclaration(node);
  }
}
