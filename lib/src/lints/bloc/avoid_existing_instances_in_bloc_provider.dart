import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidExistingInstancesInBlocProvider extends DartLintRule {
  const AvoidExistingInstancesInBlocProvider() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_existing_instances_in_bloc_provider',
    problemMessage:
        'BlocProvider should create a new instance instead of using an existing one.',
    correctionMessage:
        'Create the instance directly in the create callback instead of referencing an existing variable.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      final type = node.constructorName.type.name.lexeme;

      if (type != 'BlocProvider') return;

      // Check for create parameter
      for (final arg in node.argumentList.arguments) {
        if (arg is NamedExpression && arg.name.label.name == 'create') {
          final expression = arg.expression;

          // Check if the create callback returns an identifier (existing instance)
          if (expression is FunctionExpression) {
            final body = expression.body;
            if (body is ExpressionFunctionBody) {
              if (body.expression is SimpleIdentifier ||
                  body.expression is PrefixedIdentifier) {
                reporter.atNode(body.expression, _code);
              }
            } else if (body is BlockFunctionBody) {
              // Check for return statements
              body.block.visitChildren(
                _ReturnStatementVisitor(reporter, _code),
              );
            }
          }
        }
      }
    });
  }
}

class _ReturnStatementVisitor extends RecursiveAstVisitor<void> {
  _ReturnStatementVisitor(this.reporter, this.code);

  final DiagnosticReporter reporter;
  final LintCode code;

  @override
  void visitReturnStatement(ReturnStatement node) {
    super.visitReturnStatement(node);

    final expression = node.expression;
    if (expression != null &&
        (expression is SimpleIdentifier || expression is PrefixedIdentifier)) {
      reporter.atNode(expression, code);
    }
  }
}
