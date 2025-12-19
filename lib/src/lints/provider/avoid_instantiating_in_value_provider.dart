import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidInstantiatingInValueProvider extends DartLintRule {
  const AvoidInstantiatingInValueProvider() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_instantiating_in_value_provider',
    problemMessage:
        'Avoid creating new instances in Provider.value. Provider.value should reuse existing instances.',
    correctionMessage:
        'Pass an existing instance to the value parameter instead of creating a new one.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      // Check if this instance creation is the value argument of Provider.value
      if (_isValueArgumentOfProviderValue(node)) {
        reporter.atNode(node, _code);
      }
    });
  }

  bool _isValueArgumentOfProviderValue(InstanceCreationExpression node) {
    // Navigate up to find if we're in a named argument
    final parent = node.parent;
    if (parent is! NamedExpression) return false;

    // Check if the argument name is 'value'
    if (parent.name.label.name != 'value') return false;

    // Navigate up to the argument list
    final argumentList = parent.parent;
    if (argumentList is! ArgumentList) return false;

    // Navigate up to the method/constructor invocation
    final invocation = argumentList.parent;
    if (invocation is! InstanceCreationExpression) return false;

    // Check if this is a Provider.value constructor
    final constructorName = invocation.constructorName;
    final typeName = constructorName.type.name.lexeme;
    final constructorSuffix = constructorName.name?.name;

    // Check for Provider.value() or any Provider variant with .value
    return (typeName.contains('Provider') && constructorSuffix == 'value');
  }
}
