import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:custom_lint_builder/custom_lint_builder.dart';

import 'base/magic_value_lint.dart';

class NoMagicNumber extends MagicValueLint {
  const NoMagicNumber() : super(code: _code);

  static const _code = LintCode(
    name: 'no_magic_number',
    problemMessage:
        'Avoid using magic numbers. Extract them into named constants for better readability and maintainability.',
    correctionMessage:
        'Define a named constant with a descriptive name for this number.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  // Default allowed numbers
  static const _defaultAllowedNumbers = [-1, 0, 1];

  @override
  bool isAllowedValue(Literal node) {
    if (node is IntegerLiteral) {
      return _defaultAllowedNumbers.contains(node.value);
    }
    if (node is DoubleLiteral) {
      return _defaultAllowedNumbers.contains(node.value);
    }
    return false;
  }

  @override
  bool shouldCheckLiteral(Literal node) {
    return node is IntegerLiteral || node is DoubleLiteral;
  }

  @override
  void registerLiteralChecks(
    CustomLintContext context,
    void Function(Literal) checkLiteral,
  ) {
    context.registry.addIntegerLiteral(checkLiteral);
    context.registry.addDoubleLiteral(checkLiteral);
  }

  @override
  bool hasCustomExclusion(Literal node) {
    // Don't report if it's in a DateTime constructor
    if (_isInDateTimeConstructor(node)) {
      return true;
    }

    // Don't report if it's a list/map/set index
    if (_isCollectionIndex(node)) {
      return true;
    }

    return false;
  }

  bool _isInDateTimeConstructor(AstNode node) {
    AstNode? current = node.parent;
    while (current != null) {
      if (current is InstanceCreationExpression) {
        final type = current.staticType;
        if (type != null && type.getDisplayString() == 'DateTime') {
          return true;
        }
      }
      if (current is MethodInvocation) {
        final target = current.target;
        if (target is SimpleIdentifier && target.name == 'DateTime') {
          return true;
        }
      }
      current = current.parent;
    }
    return false;
  }

  bool _isCollectionIndex(AstNode node) {
    final parent = node.parent;
    return parent is IndexExpression && parent.index == node;
  }
}
