import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferImmutableSelectorValue extends DartLintRule {
  const PreferImmutableSelectorValue() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_immutable_selector_value',
    problemMessage:
        'Selector should return an immutable value to ensure correct rebuilds.',
    correctionMessage:
        'Mark the returned class with @immutable and implement proper equality checks.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      if (!_isSelectorWidget(node)) return;

      final selectorFunction = _getSelectorFunction(node);
      if (selectorFunction == null) return;

      final returnType = _getReturnType(selectorFunction);
      if (returnType == null) return;

      if (!_isImmutableType(returnType)) {
        reporter.atNode(selectorFunction, _code);
      }
    });
  }

  bool _isSelectorWidget(InstanceCreationExpression node) {
    final typeName = node.constructorName.type.name.lexeme;
    return typeName == 'Selector' || typeName == 'Selector2';
  }

  Expression? _getSelectorFunction(InstanceCreationExpression node) {
    for (final argument in node.argumentList.arguments) {
      if (argument is NamedExpression &&
          argument.name.label.name == 'selector') {
        return argument.expression;
      }
    }
    return null;
  }

  ClassElement? _getReturnType(Expression selectorFunction) {
    // Try to infer the return type from the function expression
    if (selectorFunction is FunctionExpression) {
      final body = selectorFunction.body;
      if (body is ExpressionFunctionBody) {
        final expression = body.expression;
        final type = expression.staticType;
        if (type != null) {
          final element = type.element;
          if (element is ClassElement) {
            return element;
          }
        }
      } else if (body is BlockFunctionBody) {
        // For block bodies, we'd need to analyze return statements
        // For now, we'll skip this complexity
      }
    }
    return null;
  }

  bool _isImmutableType(ClassElement classElement) {
    // Check if it's a primitive or built-in immutable type
    final name = classElement.name;
    if (name != null && _isPrimitiveOrImmutable(name)) {
      return true;
    }

    // Note: Checking for @immutable annotation on ClassElement would require
    // traversing back to the AST node, which is complex for this use case.
    // For now, we only check primitive types. Users should ensure custom types
    // used in selectors are properly immutable (using @immutable and implementing ==).
    return false;
  }

  bool _isPrimitiveOrImmutable(String typeName) {
    const immutableTypes = {
      'String',
      'int',
      'double',
      'bool',
      'num',
      'Object',
      'Null',
      'Type',
      'Symbol',
    };
    return immutableTypes.contains(typeName);
  }
}
