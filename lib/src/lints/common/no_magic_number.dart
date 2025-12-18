import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class NoMagicNumber extends DartLintRule {
  const NoMagicNumber() : super(code: _code);

  static const _code = LintCode(
    name: 'no_magic_number',
    problemMessage:
        'Avoid using magic numbers. Extract them into named constants for better readability and maintainability.',
    correctionMessage:
        'Define a named constant with a descriptive name for this number.',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  // Default allowed numbers
  static const _defaultAllowedNumbers = [-1, 0, 1];

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addIntegerLiteral((node) {
      if (_shouldReport(node)) {
        reporter.atNode(node, _code);
      }
    });

    context.registry.addDoubleLiteral((node) {
      if (_shouldReport(node)) {
        reporter.atNode(node, _code);
      }
    });
  }

  bool _shouldReport(Literal node) {
    // Check if the number is in the allowed list
    if (_isAllowedNumber(node)) {
      return false;
    }

    // Don't report if it's part of a variable declaration with const/final
    if (_isPartOfConstOrFinalDeclaration(node)) {
      return false;
    }

    // Don't report if it's a default parameter value
    if (_isDefaultParameterValue(node)) {
      return false;
    }

    // Don't report if it's in a DateTime constructor
    if (_isInDateTimeConstructor(node)) {
      return false;
    }

    // Don't report if it's a list/map/set index
    if (_isCollectionIndex(node)) {
      return false;
    }

    // Don't report if it's in an annotation
    if (_isInAnnotation(node)) {
      return false;
    }

    return true;
  }

  bool _isAllowedNumber(Literal node) {
    if (node is IntegerLiteral) {
      return _defaultAllowedNumbers.contains(node.value);
    }
    if (node is DoubleLiteral) {
      return _defaultAllowedNumbers.contains(node.value);
    }
    return false;
  }

  bool _isPartOfConstOrFinalDeclaration(AstNode node) {
    AstNode? current = node.parent;
    while (current != null) {
      if (current is VariableDeclaration) {
        final parent = current.parent;
        if (parent is VariableDeclarationList) {
          return parent.isConst || parent.isFinal;
        }
      }
      // Also check for field declarations with const/final
      if (current is FieldDeclaration) {
        return current.fields.isConst || current.fields.isFinal;
      }
      // Check for top-level variable declarations
      if (current is TopLevelVariableDeclaration) {
        return current.variables.isConst || current.variables.isFinal;
      }
      current = current.parent;
    }
    return false;
  }

  bool _isDefaultParameterValue(AstNode node) {
    AstNode? current = node.parent;
    while (current != null) {
      if (current is DefaultFormalParameter) {
        return true;
      }
      current = current.parent;
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

  bool _isInAnnotation(AstNode node) {
    AstNode? current = node.parent;
    while (current != null) {
      if (current is Annotation) {
        return true;
      }
      current = current.parent;
    }
    return false;
  }
}
