import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidConstantConditions extends DartLintRule {
  const AvoidConstantConditions() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_constant_conditions',
    problemMessage:
        'This condition is constant and always evaluates to the same value.',
    correctionMessage:
        'Remove the constant condition or use a variable instead.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addIfStatement((node) {
      _checkCondition(node.expression, reporter);
    });

    context.registry.addWhileStatement((node) {
      _checkCondition(node.condition, reporter);
    });

    context.registry.addDoStatement((node) {
      _checkCondition(node.condition, reporter);
    });

    context.registry.addConditionalExpression((node) {
      _checkCondition(node.condition, reporter);
    });

    // Note: Assert statements are intentionally NOT checked here.
    // The avoid_constant_assert_conditions lint rule handles constant
    // expressions in assert statements more comprehensively.
  }

  void _checkCondition(Expression condition, DiagnosticReporter reporter) {
    if (condition is BinaryExpression) {
      final leftIsConstant = _isConstantValue(condition.leftOperand);
      final rightIsConstant = _isConstantValue(condition.rightOperand);

      if (leftIsConstant && rightIsConstant) {
        reporter.atNode(condition, _code);
      }
    }
  }

  bool _isConstantValue(Expression expression) {
    // Check for literals
    if (expression is BooleanLiteral ||
        expression is IntegerLiteral ||
        expression is DoubleLiteral ||
        expression is StringLiteral ||
        expression is NullLiteral) {
      return true;
    }

    // Check for constant variables
    if (expression is SimpleIdentifier) {
      final element = expression.element;
      if (element is VariableElement && element.isConst) {
        return true;
      }
      if (element is PropertyAccessorElement &&
          element.variable.isConst == true) {
        return true;
      }
    }

    // Check for prefixed identifiers (e.g., ClassName.constantField)
    if (expression is PrefixedIdentifier) {
      final element = expression.identifier.element;
      if (element is PropertyAccessorElement &&
          element.variable.isConst == true) {
        return true;
      }
      if (element is VariableElement && element.isConst) {
        return true;
      }
    }

    // Check for property access (e.g., object.property)
    if (expression is PropertyAccess) {
      final element = expression.propertyName.element;
      if (element is PropertyAccessorElement &&
          element.variable.isConst == true) {
        return true;
      }
      if (element is VariableElement && element.isConst) {
        return true;
      }
    }

    return false;
  }
}
