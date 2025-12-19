import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidReturningValueFromCubitMethods extends DartLintRule {
  const AvoidReturningValueFromCubitMethods() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_returning_value_from_cubit_methods',
    problemMessage:
        'Avoid Cubit methods that return a value. Try listening for a state change instead.',
    correctionMessage: 'Remove the return type and use state emission instead.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addClassDeclaration((node) {
      if (!_isCubit(node)) return;

      for (final member in node.members) {
        if (member is MethodDeclaration) {
          // Skip if method is overridden
          final hasOverride = member.metadata.any(
            (annotation) => annotation.name.name == 'override',
          );
          if (hasOverride) continue;

          // Skip constructors, getters, setters, and operators
          if (member.isGetter ||
              member.isSetter ||
              member.isOperator ||
              member.name.lexeme.startsWith('_')) {
            continue;
          }

          // Check if method has a return type other than void or Future<void>
          final returnType = member.returnType?.toString() ?? '';
          if (returnType.isNotEmpty &&
              returnType != 'void' &&
              returnType != 'Future<void>') {
            reporter.atNode(member, _code);
          }
        }
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
