import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidStatelessWidgetInitializedFields extends DartLintRule {
  const AvoidStatelessWidgetInitializedFields() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_stateless_widget_initialized_fields',
    problemMessage:
        'StatelessWidget should not have initialized instance fields. '
        'Consider using static fields or converting to StatefulWidget.',
    correctionMessage:
        'Make field static or convert widget to StatefulWidget if state is needed.',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addClassDeclaration((node) {
      final element = node.declaredFragment?.element;
      if (element == null) return;

      // Check if it extends StatelessWidget
      final superType = element.supertype;
      if (superType == null || superType.element3.name3 != 'StatelessWidget') {
        return;
      }

      // Use visitor to find initialized instance fields
      final visitor = _StatelessFieldVisitor(reporter, _code);
      node.visitChildren(visitor);
    });
  }
}

class _StatelessFieldVisitor extends RecursiveAstVisitor<void> {
  final ErrorReporter reporter;
  final LintCode code;

  _StatelessFieldVisitor(this.reporter, this.code);

  @override
  void visitFieldDeclaration(FieldDeclaration node) {
    // Skip static fields - they are allowed
    if (node.isStatic) {
      super.visitFieldDeclaration(node);
      return;
    }

    // Check each variable in the field declaration
    for (final variable in node.fields.variables) {
      // Report if the field has an initializer
      if (variable.initializer != null) {
        reporter.atNode(variable, code);
      }
    }

    super.visitFieldDeclaration(node);
  }
}
