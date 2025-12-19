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

    // Track if we're in a return context or assignment context
    String? assignmentTarget;
    bool allReturn = true;
    bool allAssignment = true;

    for (final member in node.members) {
      // Skip default cases for now (they can be handled but let's keep it simple)
      if (member is! SwitchCase) {
        // If there's a default case, we can still convert it
        if (member is SwitchDefault) {
          final result = _analyzeMember(member);
          if (result == null) return false;

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

    // Must be all returns or all assignments to same variable
    return allReturn || allAssignment;
  }

  _MemberAnalysisResult? _analyzeMember(SwitchMember member) {
    final statements = member.statements;
    if (statements.isEmpty) return null;

    final lastStatement = statements.last;

    // Case 1: Single return statement (or variable declaration + return)
    if (lastStatement is ReturnStatement) {
      // Return with a value
      if (lastStatement.expression != null) {
        // Check all preceding statements are variable declarations
        for (var i = 0; i < statements.length - 1; i++) {
          if (statements[i] is! VariableDeclarationStatement) {
            return null;
          }
        }
        return _MemberAnalysisResult(isReturn: true);
      }
      // Return without value can't be converted
      return null;
    }

    // Case 2: Assignment + break
    // Look for pattern: variable = value; break;
    if (statements.length >= 2 && lastStatement is BreakStatement) {
      final secondLast = statements[statements.length - 2];
      if (secondLast is ExpressionStatement) {
        final expression = secondLast.expression;
        if (expression is AssignmentExpression &&
            expression.leftHandSide is SimpleIdentifier) {
          // Check all other statements (except last 2) are variable declarations
          for (var i = 0; i < statements.length - 2; i++) {
            if (statements[i] is! VariableDeclarationStatement) {
              return null;
            }
          }
          final target = (expression.leftHandSide as SimpleIdentifier).name;
          return _MemberAnalysisResult(
            isAssignment: true,
            assignmentTarget: target,
          );
        }
      }
    }

    // Case 3: Just a break statement means empty case
    if (statements.length == 1 && lastStatement is BreakStatement) {
      return null;
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
