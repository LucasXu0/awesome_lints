import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidConstantSwitches extends DartLintRule {
  const AvoidConstantSwitches() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_constant_switches',
    problemMessage:
        'This switch expression evaluates a constant value and always produces the same result.',
    correctionMessage:
        'Use a variable or parameter instead of a constant value.',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addSwitchStatement((node) {
      if (_isConstantExpression(node.expression)) {
        reporter.atNode(
          node.expression,
          _code,
        );
      }
    });

    context.registry.addSwitchExpression((node) {
      if (_isConstantExpression(node.expression)) {
        reporter.atNode(
          node.expression,
          _code,
        );
      }
    });
  }

  bool _isConstantExpression(Expression expression) {
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
      if (element is VariableElement2 && element.isConst) {
        return true;
      }
      if (element is PropertyAccessorElement2 &&
          element.variable3?.isConst == true) {
        return true;
      }
    }

    // Check for prefixed identifiers (e.g., ClassName.constantField)
    if (expression is PrefixedIdentifier) {
      final element = expression.identifier.element;
      if (element is PropertyAccessorElement2 &&
          element.variable3?.isConst == true) {
        return true;
      }
      if (element is VariableElement2 && element.isConst) {
        return true;
      }
    }

    // Check for property access (e.g., object.property)
    if (expression is PropertyAccess) {
      final element = expression.propertyName.element;
      if (element is PropertyAccessorElement2 &&
          element.variable3?.isConst == true) {
        return true;
      }
      if (element is VariableElement2 && element.isConst) {
        return true;
      }
    }

    return false;
  }
}
