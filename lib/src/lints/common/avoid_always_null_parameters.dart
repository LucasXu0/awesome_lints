import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidAlwaysNullParameters extends DartLintRule {
  const AvoidAlwaysNullParameters() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_always_null_parameters',
    problemMessage: 'This parameter always receives null and can be removed.',
    correctionMessage: 'Remove the parameter from the function signature.',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    // Collect all private function/method declarations and their parameters
    final privateDeclarations =
        <ExecutableElement2, List<FormalParameterElement>>{};
    // Track parameter usages: element -> list of argument values
    final parameterUsages = <FormalParameterElement, List<Expression?>>{};
    // Track AST nodes for declarations
    final declarationNodes = <ExecutableElement2, AstNode>{};

    // First pass: collect private function/method declarations
    context.registry.addFunctionDeclaration((node) {
      final element = node.declaredFragment?.element;
      if (element != null && element.displayName.startsWith('_')) {
        final nullableParams = element.formalParameters
            .where((p) => p.type.nullabilitySuffix.toString().contains('?'))
            .toList();
        if (nullableParams.isNotEmpty) {
          privateDeclarations[element] = nullableParams;
          declarationNodes[element] = node;
          for (final param in nullableParams) {
            parameterUsages[param] = [];
          }
        }
      }
    });

    context.registry.addMethodDeclaration((node) {
      final element = node.declaredFragment?.element;
      if (element != null && element.displayName.startsWith('_')) {
        final nullableParams = element.formalParameters
            .where((p) => p.type.nullabilitySuffix.toString().contains('?'))
            .toList();
        if (nullableParams.isNotEmpty) {
          privateDeclarations[element] = nullableParams;
          declarationNodes[element] = node;
          for (final param in nullableParams) {
            parameterUsages[param] = [];
          }
        }
      }
    });

    // Second pass: collect all invocations
    context.registry.addMethodInvocation((node) {
      final element = node.methodName.element;
      if (element is ExecutableElement2 &&
          privateDeclarations.containsKey(element)) {
        _recordArguments(node.argumentList, element, parameterUsages);
      }
    });

    context.registry.addFunctionExpressionInvocation((node) {
      final element = node.element;
      if (element != null && privateDeclarations.containsKey(element)) {
        _recordArguments(node.argumentList, element, parameterUsages);
      }
    });

    // Use addCompilationUnit to run analysis after all nodes have been visited
    context.registry.addCompilationUnit((node) {
      // After collecting all usages, check which parameters always receive null
      for (final entry in privateDeclarations.entries) {
        final function = entry.key;
        final parameters = entry.value;

        // Check if ANY parameter always receives null
        var hasAlwaysNullParam = false;
        for (final param in parameters) {
          final usages = parameterUsages[param] ?? [];

          // If there are no usages, skip (can't determine)
          if (usages.isEmpty) continue;

          // Check if all usages are null
          final allNull = usages.every((arg) => _isNullLiteral(arg));

          if (allNull) {
            hasAlwaysNullParam = true;
            break;
          }
        }

        // If any parameter always receives null, report on the function/method declaration
        if (hasAlwaysNullParam) {
          final declNode = declarationNodes[function];
          if (declNode != null) {
            final reportNode = _getFunctionNameNode(declNode);
            if (reportNode != null) {
              reporter.atNode(
                reportNode,
                _code,
              );
            }
          }
        }
      }
    });
  }

  void _recordArguments(
    ArgumentList argumentList,
    ExecutableElement2 function,
    Map<FormalParameterElement, List<Expression?>> parameterUsages,
  ) {
    for (final param in function.formalParameters) {
      if (!parameterUsages.containsKey(param)) continue;

      // Find the corresponding argument
      Expression? argument;

      // Check positional arguments
      if (!param.isNamed) {
        final index = function.formalParameters.indexOf(param);
        final positionalArgs = argumentList.arguments
            .whereType<Expression>()
            .where((arg) => arg is! NamedExpression)
            .toList();
        if (index < positionalArgs.length) {
          argument = positionalArgs[index];
        }
      } else {
        // Check named arguments
        final namedArg = argumentList.arguments
            .whereType<NamedExpression>()
            .where((arg) => arg.name.label.name == param.displayName)
            .firstOrNull;
        argument = namedArg?.expression;
      }

      parameterUsages[param]!.add(argument);
    }
  }

  bool _isNullLiteral(Expression? expression) {
    return expression is NullLiteral || expression == null;
  }

  AstNode? _getFunctionNameNode(AstNode declNode) {
    if (declNode is FunctionDeclaration) {
      return declNode.functionExpression.parameters;
    } else if (declNode is MethodDeclaration) {
      return declNode.parameters;
    }
    return null;
  }
}
