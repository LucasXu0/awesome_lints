import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class ProperSuperCalls extends DartLintRule {
  const ProperSuperCalls() : super(code: _code);

  static const _code = LintCode(
    name: 'proper_super_calls',
    problemMessage:
        'Super call must be in correct position for this lifecycle method.',
    correctionMessage:
        'For initState/activate/didUpdateWidget: super must be first statement. For dispose/deactivate: super must be last statement.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  // Lifecycle methods where super must be called FIRST
  static const _superFirstMethods = {
    'initState',
    'activate',
    'didUpdateWidget',
  };

  // Lifecycle methods where super must be called LAST
  static const _superLastMethods = {'dispose', 'deactivate'};

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodDeclaration((node) {
      // Check if the enclosing class extends State
      final classNode = node.thisOrAncestorOfType<ClassDeclaration>();
      if (classNode == null) return;

      final extendsClause = classNode.extendsClause;
      if (extendsClause == null) return;

      final superclass = extendsClause.superclass;
      final superclassName = superclass.element?.displayName;

      // Check if it extends State (could be "State" or "State<Widget>")
      if (superclassName == null ||
          (superclassName != 'State' && !superclassName.startsWith('State<'))) {
        return;
      }

      final methodName = node.name.lexeme;

      // Check if this is one of the lifecycle methods we care about
      if (!_superFirstMethods.contains(methodName) &&
          !_superLastMethods.contains(methodName)) {
        return;
      }

      // Get the method body
      final body = node.body;
      if (body is! BlockFunctionBody) return;

      final block = body.block;
      final statements = block.statements;

      // If method is empty, no issue
      if (statements.isEmpty) return;

      // Find the super call position
      int? superCallIndex;
      for (int i = 0; i < statements.length; i++) {
        final statement = statements[i];
        if (_containsSuperCall(statement, methodName)) {
          superCallIndex = i;
          break;
        }
      }

      // If there's no super call, no issue to report
      if (superCallIndex == null) return;

      // Check if super call is in the correct position
      if (_superFirstMethods.contains(methodName)) {
        // Super must be first statement
        if (superCallIndex != 0) {
          reporter.atNode(node, _code);
        }
      } else if (_superLastMethods.contains(methodName)) {
        // Super must be last statement
        if (superCallIndex != statements.length - 1) {
          reporter.atNode(node, _code);
        }
      }
    });
  }

  bool _containsSuperCall(Statement statement, String methodName) {
    // Handle expression statement: super.method();
    if (statement is ExpressionStatement) {
      final expression = statement.expression;
      if (expression is MethodInvocation) {
        final target = expression.target;
        if (target is SuperExpression &&
            expression.methodName.name == methodName) {
          return true;
        }
      }
    }

    return false;
  }
}
