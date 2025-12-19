import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidBlocPublicFields extends DartLintRule {
  const AvoidBlocPublicFields() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_bloc_public_fields',
    problemMessage:
        'Avoid declaring public fields for Blocs or Cubits. Try making them private instead.',
    correctionMessage:
        'Make the field private by prefixing it with an underscore (_).',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addClassDeclaration((node) {
      if (!_isBlocOrCubit(node)) return;

      // Check all fields in the class
      for (final member in node.members) {
        if (member is FieldDeclaration) {
          // Check if the field is public (doesn't start with _)
          for (final variable in member.fields.variables) {
            final fieldName = variable.name.lexeme;
            if (!fieldName.startsWith('_')) {
              reporter.atNode(variable, _code);
            }
          }
        }
      }
    });
  }

  bool _isBlocOrCubit(ClassDeclaration node) {
    final extendsClause = node.extendsClause;
    if (extendsClause == null) return false;

    final superclass = extendsClause.superclass;
    final superclassName = superclass.name.lexeme;

    return superclassName == 'Bloc' || superclassName == 'Cubit';
  }
}
