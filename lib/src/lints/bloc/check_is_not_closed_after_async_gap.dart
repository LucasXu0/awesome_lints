import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class CheckIsNotClosedAfterAsyncGap extends DartLintRule {
  const CheckIsNotClosedAfterAsyncGap() : super(code: _code);

  static const _code = LintCode(
    name: 'check_is_not_closed_after_async_gap',
    problemMessage:
        'Add an isClosed check before dispatching an event after an async gap.',
    correctionMessage:
        'Wrap the event dispatch in an if (!isClosed) check to prevent dispatching to a closed Bloc.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addClassDeclaration((node) {
      if (!_isBlocOrCubit(node)) return;

      for (final member in node.members) {
        if (member is ConstructorDeclaration) {
          member.body.visitChildren(_AsyncGapVisitor(reporter, _code));
        }
      }
    });
  }

  bool _isBlocOrCubit(ClassDeclaration node) {
    final extendsClause = node.extendsClause;
    if (extendsClause == null) return false;

    final superclass = extendsClause.superclass;
    final superclassName = superclass.name.lexeme;

    return superclassName == 'Bloc' || superclassName == 'Cubit';
  }
}

class _AsyncGapVisitor extends GeneralizingAstVisitor<void> {
  _AsyncGapVisitor(this.reporter, this.code);

  final DiagnosticReporter reporter;
  final LintCode code;

  @override
  void visitFunctionExpression(FunctionExpression node) {
    super.visitFunctionExpression(node);

    if (!node.body.isAsynchronous) return;

    final body = node.body;
    if (body is! BlockFunctionBody) return;

    _checkBlockForAsyncGap(body.block);
  }

  void _checkBlockForAsyncGap(Block block) {
    bool foundAwait = false;

    for (final statement in block.statements) {
      // Check for await expressions
      statement.visitChildren(
        _AwaitVisitor((hasAwait) {
          foundAwait = hasAwait;
        }),
      );

      // After an await, check for add() calls without isClosed check
      if (foundAwait) {
        statement.visitChildren(_AddCallVisitor(reporter, code));
      }
    }
  }
}

class _AwaitVisitor extends GeneralizingAstVisitor<void> {
  _AwaitVisitor(this.onAwait);

  final void Function(bool) onAwait;

  @override
  void visitAwaitExpression(AwaitExpression node) {
    super.visitAwaitExpression(node);
    onAwait(true);
  }
}

class _AddCallVisitor extends GeneralizingAstVisitor<void> {
  _AddCallVisitor(this.reporter, this.code);

  final DiagnosticReporter reporter;
  final LintCode code;

  @override
  void visitMethodInvocation(MethodInvocation node) {
    super.visitMethodInvocation(node);

    if (node.methodName.name == 'add') {
      // Check if it's wrapped in an isClosed check
      if (!_isInsideIsClosedCheck(node)) {
        reporter.atNode(node, code);
      }
    }
  }

  bool _isInsideIsClosedCheck(AstNode node) {
    AstNode? current = node.parent;
    while (current != null) {
      if (current is IfStatement && _isClosedCheck(current.expression)) {
        // Make sure we're in the then statement, not the else
        if (_isDescendantOf(node, current.thenStatement)) {
          return true;
        }
      }
      // Stop at function boundaries
      if (current is FunctionExpression) break;
      current = current.parent;
    }
    return false;
  }

  bool _isDescendantOf(AstNode node, AstNode ancestor) {
    AstNode? current = node;
    while (current != null) {
      if (identical(current, ancestor)) return true;
      current = current.parent;
    }
    return false;
  }

  bool _isClosedCheck(Expression expression) {
    if (expression is PrefixExpression && expression.operator.lexeme == '!') {
      final operand = expression.operand;
      if (operand is SimpleIdentifier && operand.name == 'isClosed') {
        return true;
      }
    }
    return false;
  }
}
