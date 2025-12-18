import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class ArgumentsOrdering extends DartLintRule {
  const ArgumentsOrdering() : super(code: _code);

  static const _code = LintCode(
    name: 'arguments_ordering',
    problemMessage:
        'Named arguments should follow the parameter declaration order.',
    correctionMessage:
        'Reorder the named arguments to match the parameter declaration order.',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addArgumentList((node) {
      // Get all named arguments
      final namedArguments =
          node.arguments.whereType<NamedExpression>().toList();

      // Need at least 2 named arguments to check ordering
      if (namedArguments.length < 2) return;

      // Get the invocation target (function, method, or constructor)
      final parent = node.parent;
      if (parent == null) return;

      // Get parameter elements to determine declaration order
      List<String>? parameterOrder;

      if (parent is MethodInvocation) {
        final element = parent.methodName.element;
        if (element is ExecutableElement2) {
          parameterOrder = element.formalParameters
              .where((p) => p.isNamed)
              .map((p) => p.displayName)
              .toList();
        }
      } else if (parent is FunctionExpressionInvocation) {
        final element = parent.element;
        if (element is ExecutableElement2) {
          parameterOrder = element.formalParameters
              .where((p) => p.isNamed)
              .map((p) => p.displayName)
              .toList();
        }
      } else if (parent is InstanceCreationExpression) {
        final element = parent.constructorName.element;
        if (element is ConstructorElement2) {
          parameterOrder = element.formalParameters
              .where((p) => p.isNamed)
              .map((p) => p.displayName)
              .toList();
        }
      }

      if (parameterOrder == null || parameterOrder.isEmpty) return;

      // Check if arguments follow the declaration order
      final argumentNames =
          namedArguments.map((arg) => arg.name.label.name).toList();

      // Filter parameter order to only include arguments that are present
      final relevantParameterOrder = parameterOrder
          .where((param) => argumentNames.contains(param))
          .toList();

      // Check if the argument order matches the parameter order
      bool isOrdered = true;
      for (int i = 0; i < argumentNames.length; i++) {
        if (i >= relevantParameterOrder.length ||
            argumentNames[i] != relevantParameterOrder[i]) {
          isOrdered = false;
          break;
        }
      }

      if (!isOrdered) {
        reporter.atNode(
          node,
          _code,
        );
      }
    });
  }
}
