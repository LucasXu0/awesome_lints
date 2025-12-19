import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferNamedBooleanParameters extends DartLintRule {
  const PreferNamedBooleanParameters() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_named_boolean_parameters',
    problemMessage:
        'Positional boolean parameters are unclear at call site. Use named parameters instead.',
    correctionMessage:
        'Convert positional boolean parameters to named parameters for better readability.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addFunctionDeclaration((node) {
      final params = node.functionExpression.parameters;
      if (params != null) {
        _checkParameters(params, reporter);
      }
    });

    context.registry.addMethodDeclaration((node) {
      if (node.parameters != null) {
        _checkParameters(node.parameters!, reporter);
      }
    });

    context.registry.addConstructorDeclaration((node) {
      _checkParameters(node.parameters, reporter);
    });
  }

  void _checkParameters(
    FormalParameterList parameterList,
    DiagnosticReporter reporter,
  ) {
    // Get all positional parameters (not named)
    final positionalParams = parameterList.parameters
        .where((param) => !param.isNamed)
        .toList();

    // Check each positional parameter for boolean type
    for (final param in positionalParams) {
      if (_isBooleanParameter(param)) {
        reporter.atNode(param, _code);
      }
    }
  }

  bool _isBooleanParameter(FormalParameter param) {
    TypeAnnotation? typeAnnotation;

    // Extract the type annotation based on parameter type
    if (param is SimpleFormalParameter) {
      typeAnnotation = param.type;
    } else if (param is DefaultFormalParameter) {
      final innerParam = param.parameter;
      if (innerParam is SimpleFormalParameter) {
        typeAnnotation = innerParam.type;
      } else if (innerParam is FieldFormalParameter) {
        typeAnnotation = innerParam.type;
      }
    } else if (param is FieldFormalParameter) {
      typeAnnotation = param.type;
    }

    // Check if the type annotation is 'bool'
    if (typeAnnotation != null) {
      if (typeAnnotation is NamedType) {
        return typeAnnotation.name.lexeme == 'bool';
      }
      // Fallback to string representation
      return typeAnnotation.toString() == 'bool';
    }

    return false;
  }
}
