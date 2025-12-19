import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidPassingBuildContextToBlocs extends DartLintRule {
  const AvoidPassingBuildContextToBlocs() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_passing_build_context_to_blocs',
    problemMessage:
        'Avoid passing BuildContext to Bloc events or Cubit methods.',
    correctionMessage:
        'Remove BuildContext parameters to avoid coupling between Blocs and widgets.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    // Check class declarations for Cubit methods with BuildContext parameters
    context.registry.addClassDeclaration((node) {
      if (!_isCubit(node)) return;

      for (final member in node.members) {
        if (member is MethodDeclaration) {
          for (final param in member.parameters?.parameters ?? []) {
            if (_isBuildContextParameter(param)) {
              reporter.atNode(param, _code);
            }
          }
        }
      }
    });

    // Check for event classes with BuildContext parameters
    context.registry.addClassDeclaration((node) {
      // Simple heuristic: classes ending with 'Event'
      if (!node.name.lexeme.endsWith('Event')) return;

      for (final member in node.members) {
        if (member is ConstructorDeclaration) {
          for (final param in member.parameters.parameters) {
            if (_isBuildContextParameter(param)) {
              reporter.atNode(param, _code);
            }
          }
        }
        if (member is FieldDeclaration) {
          final type = member.fields.type;
          if (type != null && _isBuildContextType(type)) {
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

  bool _isBuildContextParameter(FormalParameter param) {
    if (param is SimpleFormalParameter) {
      return _isBuildContextType(param.type);
    }
    return false;
  }

  bool _isBuildContextType(TypeAnnotation? type) {
    return type?.toString() == 'BuildContext';
  }
}
