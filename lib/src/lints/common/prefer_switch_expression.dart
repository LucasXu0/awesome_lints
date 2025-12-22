import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferSwitchExpression extends DartLintRule {
  const PreferSwitchExpression() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_switch_expression',
    problemMessage: 'Switch statement can be converted to a switch expression.',
    correctionMessage:
        'Consider using a switch expression for more concise and functional code.',
    errorSeverity: analyzer_error.DiagnosticSeverity.INFO,
  );

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
    // Must have at least one member
    if (node.members.isEmpty) return false;

    // Must have more than one member (single case switches are not worth converting)
    if (node.members.length < 2) return false;

    // Track if we're in a return context or assignment context
    String? assignmentTarget;
    bool allReturn = true;
    bool allAssignment = true;
    int validMemberCount =
        0; // Track how many members were successfully analyzed

    for (final member in node.members) {
      // Skip default cases for now (they can be handled but let's keep it simple)
      if (member is! SwitchCase) {
        // If there's a default case, we can still convert it
        if (member is SwitchDefault) {
          final result = _analyzeMember(member);
          if (result == null) return false;

          validMemberCount++; // Successfully analyzed this default case

          if (result.isReturn) {
            allAssignment = false;
          } else if (result.isAssignment) {
            allReturn = false;
            if (assignmentTarget == null) {
              assignmentTarget = result.assignmentTarget;
            } else if (assignmentTarget != result.assignmentTarget) {
              // Different assignment targets
              return false;
            }
          } else {
            return false;
          }
        }
        continue;
      }

      // Empty cases (fall-through) can't be converted
      if (member.statements.isEmpty) return false;

      final result = _analyzeMember(member);
      if (result == null) return false;

      validMemberCount++; // Successfully analyzed this member

      if (result.isReturn) {
        allAssignment = false;
      } else if (result.isAssignment) {
        allReturn = false;
        if (assignmentTarget == null) {
          assignmentTarget = result.assignmentTarget;
        } else if (assignmentTarget != result.assignmentTarget) {
          // Different assignment targets
          return false;
        }
      } else {
        return false;
      }
    }

    // Must have at least one valid member and all must be returns or all assignments
    return validMemberCount > 0 && (allReturn || allAssignment);
  }

  _MemberAnalysisResult? _analyzeMember(SwitchMember member) {
    final statements = member.statements;
    if (statements.isEmpty) return null;

    // Reject any complex control flow patterns
    for (final stmt in statements) {
      // Reject if/try/loops/switch/continue
      if (stmt is IfStatement) return null;
      if (stmt is TryStatement) return null;
      if (stmt is ForStatement) return null;
      if (stmt is WhileStatement) return null;
      if (stmt is DoStatement) return null;
      if (stmt is SwitchStatement) return null;
      if (stmt is ContinueStatement) return null;
      if (stmt is VariableDeclarationStatement) return null;

      // Reject throw/print/function calls (side effects)
      if (stmt is ExpressionStatement) {
        final expr = stmt.expression;
        if (expr is ThrowExpression) return null;
        if (expr is MethodInvocation) return null;
        if (expr is FunctionExpressionInvocation) return null;
      }
    }

    final last = statements.last;

    // Pattern 1: Single return with value
    if (statements.length == 1 &&
        last is ReturnStatement &&
        last.expression != null) {
      return _MemberAnalysisResult(isReturn: true);
    }

    // Pattern 2: Assignment + break (exactly 2 statements)
    if (statements.length == 2 && last is BreakStatement) {
      final first = statements[0];
      if (first is ExpressionStatement &&
          first.expression is AssignmentExpression) {
        final assignment = first.expression as AssignmentExpression;
        if (assignment.leftHandSide is! SimpleIdentifier) return null;

        // Reject if right-hand side has side effects
        final rhs = assignment.rightHandSide;
        if (rhs is MethodInvocation) return null;
        if (rhs is FunctionExpressionInvocation) return null;
        if (rhs is AwaitExpression) return null;

        return _MemberAnalysisResult(
          isAssignment: true,
          assignmentTarget: (assignment.leftHandSide as SimpleIdentifier).name,
        );
      }
    }

    return null;
  }
}

class _MemberAnalysisResult {
  final bool isReturn;
  final bool isAssignment;
  final String? assignmentTarget;

  _MemberAnalysisResult({
    this.isReturn = false,
    this.isAssignment = false,
    this.assignmentTarget,
  });
}
