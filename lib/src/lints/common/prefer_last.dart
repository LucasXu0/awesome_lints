import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/diagnostic/diagnostic.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferLast extends DartLintRule {
  const PreferLast() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_last',
    problemMessage:
        'Prefer using .last instead of [array.length - 1] or .elementAt(array.length - 1).',
    correctionMessage: 'Use .last for better readability.',
    errorSeverity: analyzer_error.DiagnosticSeverity.INFO,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addIndexExpression((node) {
      _checkIndexExpression(node, reporter);
    });

    context.registry.addMethodInvocation((node) {
      _checkElementAtInvocation(node, reporter);
    });
  }

  void _checkIndexExpression(
    IndexExpression node,
    DiagnosticReporter reporter,
  ) {
    final index = node.index;

    // Check if accessing [array.length - 1]
    if (_isLengthMinusOne(index, node.target)) {
      reporter.atNode(node, _code);
    }
  }

  void _checkElementAtInvocation(
    MethodInvocation node,
    DiagnosticReporter reporter,
  ) {
    // Check if calling elementAt(array.length - 1)
    if (node.methodName.name != 'elementAt') {
      return;
    }

    final arguments = node.argumentList.arguments;
    if (arguments.length != 1) {
      return;
    }

    final argument = arguments.first;
    if (_isLengthMinusOne(argument, node.target)) {
      reporter.atNode(node, _code);
    }
  }

  bool _isLengthMinusOne(Expression index, Expression? target) {
    // Check if the index is "length - 1" or "target.length - 1"
    if (index is! BinaryExpression) {
      return false;
    }

    if (index.operator.lexeme != '-') {
      return false;
    }

    // Check if right operand is 1
    if (index.rightOperand is! IntegerLiteral) {
      return false;
    }

    final rightValue = (index.rightOperand as IntegerLiteral).value;
    if (rightValue != 1) {
      return false;
    }

    // Check if left operand is length access
    final leftOperand = index.leftOperand;

    // Case 1: Simple property access (e.g., array.length)
    if (leftOperand is PropertyAccess) {
      if (leftOperand.propertyName.name != 'length') {
        return false;
      }

      // Verify it's accessing the same target
      if (target != null && leftOperand.target != null) {
        return _isSameExpression(leftOperand.target!, target);
      }
      return true;
    }

    // Case 2: Prefixed identifier (e.g., list.length where list is the target)
    if (leftOperand is PrefixedIdentifier) {
      if (leftOperand.identifier.name != 'length') {
        return false;
      }

      // Verify it's accessing the same target
      if (target is SimpleIdentifier) {
        return leftOperand.prefix.name == target.name;
      }
      return true;
    }

    return false;
  }

  bool _isSameExpression(Expression expr1, Expression expr2) {
    // Simple check: compare string representation
    // This handles most common cases
    return expr1.toString() == expr2.toString();
  }

  @override
  List<Fix> getFixes() => [_ReplaceWithLast()];
}

class _ReplaceWithLast extends DartFix {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    Diagnostic analysisError,
    List<Diagnostic> others,
  ) {
    context.registry.addIndexExpression((node) {
      if (!analysisError.sourceRange.intersects(node.sourceRange)) return;

      final target = node.target;
      if (target == null) return;

      final changeBuilder = reporter.createChangeBuilder(
        message: 'Replace with .last',
        priority: 80,
      );

      changeBuilder.addDartFileEdit((builder) {
        builder.addSimpleReplacement(
          node.sourceRange,
          '${target.toSource()}.last',
        );
      });
    });

    context.registry.addMethodInvocation((node) {
      if (!analysisError.sourceRange.intersects(node.sourceRange)) return;

      if (node.methodName.name != 'elementAt') return;

      final target = node.target;
      if (target == null) return;

      final changeBuilder = reporter.createChangeBuilder(
        message: 'Replace with .last',
        priority: 80,
      );

      changeBuilder.addDartFileEdit((builder) {
        builder.addSimpleReplacement(
          node.sourceRange,
          '${target.toSource()}.last',
        );
      });
    });
  }
}
