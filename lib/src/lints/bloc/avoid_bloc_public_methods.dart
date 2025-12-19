import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidBlocPublicMethods extends DartLintRule {
  const AvoidBlocPublicMethods() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_bloc_public_methods',
    problemMessage:
        'Avoid declaring public methods for Blocs. Try making them private or use events instead.',
    correctionMessage:
        'Make the method private by prefixing it with an underscore (_) or communicate via events using add().',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addClassDeclaration((node) {
      if (!_isBloc(node)) return;

      // Check all methods in the class
      for (final member in node.members) {
        if (member is MethodDeclaration) {
          final methodName = member.name.lexeme;

          // Skip if method is private
          if (methodName.startsWith('_')) continue;

          // Skip if method is overridden (has @override annotation)
          final hasOverride = member.metadata.any(
            (annotation) => annotation.name.name == 'override',
          );
          if (hasOverride) continue;

          // Skip constructors
          if (member.isOperator || member.isSetter || member.isGetter) {
            continue;
          }

          reporter.atNode(member, _code);
        }
      }
    });
  }

  bool _isBloc(ClassDeclaration node) {
    final extendsClause = node.extendsClause;
    if (extendsClause == null) return false;

    final superclass = extendsClause.superclass;
    final superclassName = superclass.name.lexeme;

    return superclassName == 'Bloc';
  }
}
