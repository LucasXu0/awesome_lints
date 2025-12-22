import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferSwitchExpression extends DartLintRule {
  PreferSwitchExpression({bool ignoreFallthroughCases = false})
    : _ignoreFallthroughCases = ignoreFallthroughCases,
      super(code: _code);

  static const String ruleName = 'prefer_switch_expression';

  static const _code = LintCode(
    name: ruleName,
    problemMessage: 'Switch statement can be converted to a switch expression.',
    correctionMessage:
        'Consider using a switch expression for more concise and functional code.',
    errorSeverity: analyzer_error.DiagnosticSeverity.INFO,
  );

  final bool _ignoreFallthroughCases;

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addSwitchStatement((node) {
      if (_canBeConvertedToExpression(node)) {
        reporter.atNode(node, _code);
      }
    });
  }

  bool _canBeConvertedToExpression(SwitchStatement node) {
    if (node.members.length < 2) return false;

    String? assignmentTarget;
    bool allReturn = true;
    bool allAssignment = true;
    var analyzedMembers = 0;

    for (final member in node.members) {
      final statements = member.statements;
      if (statements.isEmpty) {
        if (_ignoreFallthroughCases) {
          continue;
        }
        return false;
      }

      final result = _analyzeStatements(statements);
      if (result == null) return false;

      analyzedMembers++;

      if (result.isReturn) {
        allAssignment = false;
      } else if (result.isAssignment) {
        allReturn = false;
        if (assignmentTarget == null) {
          assignmentTarget = result.assignmentTarget;
        } else if (assignmentTarget != result.assignmentTarget) {
          return false;
        }
      } else {
        return false;
      }
    }

    return analyzedMembers > 1 && (allReturn || allAssignment);
  }

  _MemberAnalysisResult? _analyzeStatements(NodeList<Statement> statements) {
    if (statements.length == 1) {
      final statement = statements.first;
      if (statement is ReturnStatement && statement.expression != null) {
        return const _MemberAnalysisResult.returnValue();
      }
      return null;
    }

    if (statements.length == 2) {
      final first = statements[0];
      final second = statements[1];
      if (second is! BreakStatement || second.label != null) {
        return null;
      }

      if (first is! ExpressionStatement) return null;
      final expression = first.expression;
      if (expression is! AssignmentExpression) return null;
      if (expression.operator.type != TokenType.EQ) return null;
      if (expression.leftHandSide is! SimpleIdentifier) return null;

      final rhs = expression.rightHandSide;
      if (rhs is MethodInvocation) return null;
      if (rhs is FunctionExpressionInvocation) return null;
      if (rhs is AwaitExpression) return null;

      return _MemberAnalysisResult.assignment(
        (expression.leftHandSide as SimpleIdentifier).name,
      );
    }

    return null;
  }
}

class _MemberAnalysisResult {
  const _MemberAnalysisResult._(
    this.isReturn,
    this.isAssignment,
    this.assignmentTarget,
  );

  const _MemberAnalysisResult.returnValue() : this._(true, false, null);

  const _MemberAnalysisResult.assignment(String assignmentTarget)
    : this._(false, true, assignmentTarget);

  final bool isReturn;
  final bool isAssignment;
  final String? assignmentTarget;
}
