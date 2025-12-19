import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidCubits extends DartLintRule {
  const AvoidCubits() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_cubits',
    problemMessage: 'Avoid using Cubits. Consider using Bloc instead.',
    correctionMessage:
        'Replace Cubit with Bloc to leverage transformers, concurrency packages, and event-driven architecture.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addClassDeclaration((node) {
      if (_isCubit(node)) {
        reporter.atNode(node, _code);
      }
    });
  }

  bool _isCubit(ClassDeclaration node) {
    final extendsClause = node.extendsClause;
    if (extendsClause == null) return false;

    final superclass = extendsClause.superclass;
    final superclassName = superclass.name.lexeme;

    return superclassName == 'Cubit';
  }
}
