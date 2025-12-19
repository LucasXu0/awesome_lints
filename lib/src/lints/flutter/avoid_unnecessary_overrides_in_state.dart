import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidUnnecessaryOverridesInState extends DartLintRule {
  const AvoidUnnecessaryOverridesInState() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_unnecessary_overrides_in_state',
    problemMessage:
        'Avoid unnecessary method overrides that only call super. This override can be removed.',
    correctionMessage:
        'Remove the override if it only calls super with no additional logic.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodDeclaration((node) {
      // Check if this is an override
      if (!_hasOverrideAnnotation(node)) return;

      // Check if the enclosing class extends State
      final classNode = node.thisOrAncestorOfType<ClassDeclaration>();
      if (classNode == null) return;

      final extendsClause = classNode.extendsClause;
      if (extendsClause == null) return;

      final superclass = extendsClause.superclass;
      final superclassName = superclass.element?.displayName;

      // Check if it extends State
      if (superclassName != 'State') return;

      // Check if the method body only calls super
      if (!_isUnnecessaryOverride(node)) return;

      // Report the issue
      reporter.atNode(node, _code);
    });
  }

  bool _hasOverrideAnnotation(MethodDeclaration node) {
    final metadata = node.metadata;
    for (final annotation in metadata) {
      if (annotation.name.name == 'override') {
        return true;
      }
    }
    return false;
  }

  bool _isUnnecessaryOverride(MethodDeclaration node) {
    final body = node.body;

    // Handle expression body: `=> super.method();`
    if (body is ExpressionFunctionBody) {
      final expression = body.expression;
      return _isOnlySuperCall(expression, node.name.lexeme);
    }

    // Handle block body: `{ super.method(); }`
    if (body is BlockFunctionBody) {
      final block = body.block;
      final statements = block.statements;

      // Must have exactly one statement
      if (statements.length != 1) return false;

      final statement = statements.first;

      // Handle simple expression statement
      if (statement is ExpressionStatement) {
        return _isOnlySuperCall(statement.expression, node.name.lexeme);
      }

      // Handle return statement
      if (statement is ReturnStatement) {
        final expression = statement.expression;
        if (expression == null) return false;
        return _isOnlySuperCall(expression, node.name.lexeme);
      }
    }

    return false;
  }

  bool _isOnlySuperCall(Expression expression, String methodName) {
    // Check if it's a method invocation
    if (expression is! MethodInvocation) return false;

    // Check if the target is 'super'
    final target = expression.target;
    if (target is! SuperExpression) return false;

    // Check if the method name matches
    if (expression.methodName.name != methodName) return false;

    // Check if arguments match
    // For a truly unnecessary override, the arguments should be passed through
    // without modification. We'll check that the arguments are simple identifiers
    // that match the parameters
    return _argumentsMatchParameters(expression, methodName);
  }

  bool _argumentsMatchParameters(
    MethodInvocation invocation,
    String methodName,
  ) {
    // Get the method declaration to compare parameters
    final method = invocation.thisOrAncestorOfType<MethodDeclaration>();
    if (method == null) return false;

    final parameters = method.parameters;
    if (parameters == null) return true; // No parameters, trivially matches

    final parameterList = parameters.parameters;
    final arguments = invocation.argumentList.arguments;

    // If both are empty, it's a match
    if (parameterList.isEmpty && arguments.isEmpty) return true;

    // Check positional parameters
    final positionalParams = parameterList
        .where((p) => p.isPositional)
        .map((p) => p.name?.lexeme)
        .toList();

    // For now, we'll do a simple check:
    // All arguments must be simple identifiers that match parameter names
    int positionalIndex = 0;
    for (final arg in arguments) {
      if (arg is NamedExpression) {
        // Named argument: check if it's just passing through the parameter
        final argName = arg.name.label.name;
        final argValue = arg.expression;

        if (argValue is! SimpleIdentifier) return false;
        if (argValue.name != argName) return false;
      } else {
        // Positional argument: check if it's just passing through the parameter
        if (arg is! SimpleIdentifier) return false;
        if (positionalIndex >= positionalParams.length) return false;
        if (arg.name != positionalParams[positionalIndex]) return false;
        positionalIndex++;
      }
    }

    return true;
  }
}
