import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidPassingBlocToBloc extends DartLintRule {
  const AvoidPassingBlocToBloc() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_passing_bloc_to_bloc',
    problemMessage:
        'Avoid passing Bloc instances to other Blocs. Use events or repositories instead.',
    correctionMessage:
        'Push the problem up to the presentation layer or down to the domain layer.',
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

      // Check constructor parameters
      for (final member in node.members) {
        if (member is ConstructorDeclaration) {
          for (final param in member.parameters.parameters) {
            if (_parameterIsBloc(param)) {
              reporter.atNode(param, _code);
            }
          }
        }
      }

      // Check fields
      for (final member in node.members) {
        if (member is FieldDeclaration) {
          final type = member.fields.type;
          if (type != null && _typeIsBloc(type)) {
            reporter.atNode(member, _code);
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

  bool _parameterIsBloc(FormalParameter param) {
    if (param is SimpleFormalParameter) {
      final type = param.type;
      if (type != null && _typeIsBloc(type)) {
        return true;
      }
    }
    return false;
  }

  bool _typeIsBloc(TypeAnnotation type) {
    final typeName = type.toString();
    // Simple heuristic: check if the type name contains 'Bloc' or 'Cubit'
    return typeName.contains('Bloc') || typeName.contains('Cubit');
  }
}
