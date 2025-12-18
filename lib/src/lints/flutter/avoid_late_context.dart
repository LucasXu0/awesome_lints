import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidLateContext extends DartLintRule {
  const AvoidLateContext() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_late_context',
    problemMessage:
        'Avoid accessing "context" in late field initializers. Late fields are initialized lazily, which may result in unexpected behavior.',
    correctionMessage:
        'Remove the context usage from the late field initializer or initialize the field in initState instead.',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addFieldDeclaration((node) {
      // Check if the enclosing class extends State
      final classNode = node.thisOrAncestorOfType<ClassDeclaration>();
      if (classNode == null) return;

      final extendsClause = classNode.extendsClause;
      if (extendsClause == null) return;

      final superclass = extendsClause.superclass;
      final superclassName = superclass.element2?.displayName;

      // Check if it extends State
      if (superclassName != 'State') return;

      // Check if any of the fields are late and have an initializer
      for (final field in node.fields.variables) {
        // Check if the field has the 'late' keyword
        if (!node.fields.isLate) continue;

        // Check if the field has an initializer
        final initializer = field.initializer;
        if (initializer == null) continue;

        // Check if the initializer uses 'context'
        if (_usesContext(initializer)) {
          reporter.atNode(
            field,
            _code,
          );
        }
      }
    });
  }

  bool _usesContext(Expression expression) {
    final visitor = _ContextUsageVisitor();
    expression.accept(visitor);
    return visitor.usesContext;
  }
}

class _ContextUsageVisitor extends RecursiveAstVisitor<void> {
  bool usesContext = false;

  @override
  void visitSimpleIdentifier(SimpleIdentifier node) {
    if (node.name == 'context') {
      usesContext = true;
    }
    super.visitSimpleIdentifier(node);
  }
}
