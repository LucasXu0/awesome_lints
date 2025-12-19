import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferCorrectForLoopIncrement extends DartLintRule {
  const PreferCorrectForLoopIncrement() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_correct_for_loop_increment',
    problemMessage:
        'For loop increments/decrements wrong variable. This can cause infinite loops.',
    correctionMessage:
        'Ensure the updater expression modifies the same variable declared in the loop initialization.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addForStatement((node) {
      final forLoopParts = node.forLoopParts;

      // Only check traditional for loops (not for-in or for-each)
      if (forLoopParts is ForPartsWithDeclarations) {
        _checkForLoop(forLoopParts, reporter);
      } else if (forLoopParts is ForPartsWithExpression) {
        _checkForLoopWithExpression(forLoopParts, reporter);
      }
    });
  }

  void _checkForLoop(
    ForPartsWithDeclarations forParts,
    DiagnosticReporter reporter,
  ) {
    final variables = forParts.variables.variables;
    if (variables.isEmpty) return;

    // Get the variable name(s) declared in the initialization
    final declaredVariableNames = variables.map((v) => v.name.lexeme).toSet();

    // Check each updater expression
    for (final updater in forParts.updaters) {
      final modifiedVariable = _getModifiedVariable(updater);

      if (modifiedVariable != null &&
          !declaredVariableNames.contains(modifiedVariable)) {
        reporter.atNode(updater, _code);
      }
    }
  }

  void _checkForLoopWithExpression(
    ForPartsWithExpression forParts,
    DiagnosticReporter reporter,
  ) {
    final initialization = forParts.initialization;
    if (initialization == null) return;

    // Get the variable name(s) that are being assigned in initialization
    final assignedVariableNames = _getAssignedVariables(initialization);
    if (assignedVariableNames.isEmpty) return;

    // Check each updater expression
    for (final updater in forParts.updaters) {
      final modifiedVariable = _getModifiedVariable(updater);

      if (modifiedVariable != null &&
          !assignedVariableNames.contains(modifiedVariable)) {
        reporter.atNode(updater, _code);
      }
    }
  }

  /// Extracts the variable name being modified from an updater expression
  String? _getModifiedVariable(Expression updater) {
    // Handle i++, i--
    if (updater is PostfixExpression) {
      if (updater.operand is SimpleIdentifier) {
        return (updater.operand as SimpleIdentifier).name;
      }
    }

    // Handle ++i, --i
    if (updater is PrefixExpression) {
      if (updater.operand is SimpleIdentifier) {
        return (updater.operand as SimpleIdentifier).name;
      }
    }

    // Handle i += 1, i -= 1, i = i + 1, etc.
    if (updater is AssignmentExpression) {
      if (updater.leftHandSide is SimpleIdentifier) {
        return (updater.leftHandSide as SimpleIdentifier).name;
      }
    }

    return null;
  }

  /// Extracts variable names being assigned in an initialization expression
  Set<String> _getAssignedVariables(Expression initialization) {
    final variables = <String>{};

    if (initialization is AssignmentExpression) {
      if (initialization.leftHandSide is SimpleIdentifier) {
        variables.add((initialization.leftHandSide as SimpleIdentifier).name);
      }
    }

    return variables;
  }
}
