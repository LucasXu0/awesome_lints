import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class NoEqualArguments extends DartLintRule {
  const NoEqualArguments() : super(code: _code);

  static const _code = LintCode(
    name: 'no_equal_arguments',
    problemMessage:
        'Identical arguments are passed to this invocation, which may indicate a bug.',
    correctionMessage: 'Ensure each argument has the intended unique value.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    // Check function invocations
    context.registry.addMethodInvocation((node) {
      _checkArguments(node.argumentList, reporter);
    });

    // Check instance creation (constructor calls)
    context.registry.addInstanceCreationExpression((node) {
      _checkArguments(node.argumentList, reporter);
    });

    // Check function expression invocations
    context.registry.addFunctionExpressionInvocation((node) {
      _checkArguments(node.argumentList, reporter);
    });
  }

  void _checkArguments(ArgumentList argumentList, DiagnosticReporter reporter) {
    final arguments = argumentList.arguments;

    // Need at least 2 arguments to compare
    if (arguments.length < 2) return;

    // Compare each pair of arguments
    for (var i = 0; i < arguments.length; i++) {
      for (var j = i + 1; j < arguments.length; j++) {
        final arg1 = arguments[i];
        final arg2 = arguments[j];

        // Skip if either is a named argument (we only compare positional with positional)
        if (arg1 is NamedExpression || arg2 is NamedExpression) {
          // For named arguments, compare them separately
          if (arg1 is NamedExpression && arg2 is NamedExpression) {
            if (_areExpressionsEqual(arg1.expression, arg2.expression)) {
              reporter.atNode(argumentList, _code);
              return;
            }
          }
          continue;
        }

        // Compare the expressions
        if (_areExpressionsEqual(arg1, arg2)) {
          reporter.atNode(argumentList, _code);
          return; // Only report once per argument list
        }
      }
    }
  }

  bool _areExpressionsEqual(Expression expr1, Expression expr2) {
    // Simple text-based comparison
    final text1 = expr1.toSource();
    final text2 = expr2.toSource();

    // Ignore literals (like numbers, strings) as they might legitimately be the same
    if (expr1 is Literal || expr2 is Literal) {
      // Allow identical literals except for identifiers
      if (expr1 is! BooleanLiteral &&
          expr1 is! IntegerLiteral &&
          expr1 is! DoubleLiteral &&
          expr1 is! StringLiteral) {
        return text1 == text2;
      }
      return false;
    }

    return text1 == text2 && text1.isNotEmpty;
  }
}
