import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class NoMagicString extends DartLintRule {
  const NoMagicString() : super(code: _code);

  static const _code = LintCode(
    name: 'no_magic_string',
    problemMessage:
        'Avoid using magic strings. Extract them into named constants for better maintainability and localization.',
    correctionMessage:
        'Define a named constant with a descriptive name for this string.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  // Default ignored invocations
  static const _defaultIgnoredInvocations = ['print', 'debugPrint'];

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addSimpleStringLiteral((node) {
      if (_shouldReport(node)) {
        reporter.atNode(node, _code);
      }
    });
  }

  bool _shouldReport(SimpleStringLiteral node) {
    // Don't report empty strings
    if (node.value.isEmpty) {
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

    // Don't report if it's in an annotation
    if (_isInAnnotation(node)) {
      return false;
    }

    // Don't report if it's an argument to certain methods (print, debugPrint, etc.)
    if (_isArgumentToIgnoredInvocation(node)) {
      return false;
    }

    // Don't report if it's used in assert messages
    if (_isAssertMessage(node)) {
      return false;
    }

    // Don't report if it's in a throw statement or exception constructor
    if (_isInException(node)) {
      return false;
    }

    // Don't report if it's used as a key in GlobalKey or similar constructors
    if (_isInKeyConstructor(node)) {
      return false;
    }

    // Don't report if it's a RegExp pattern
    if (_isRegExpPattern(node)) {
      return false;
    }

    // Don't report if it's a method name in string methods
    if (_isStringMethodArgument(node)) {
      return false;
    }

    return true;
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
      if (current is FieldDeclaration) {
        return current.fields.isConst || current.fields.isFinal;
      }
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

  bool _isArgumentToIgnoredInvocation(AstNode node) {
    final parent = node.parent;
    if (parent is ArgumentList) {
      final grandParent = parent.parent;
      if (grandParent is MethodInvocation) {
        final methodName = grandParent.methodName.name;
        return _defaultIgnoredInvocations.contains(methodName);
      }
      if (grandParent is FunctionExpressionInvocation) {
        final function = grandParent.function;
        if (function is SimpleIdentifier) {
          return _defaultIgnoredInvocations.contains(function.name);
        }
      }
    }
    return false;
  }

  bool _isAssertMessage(AstNode node) {
    final parent = node.parent;
    if (parent is ArgumentList) {
      final grandParent = parent.parent;
      if (grandParent is AssertStatement) {
        // Check if this is the second argument (the message)
        final args = parent.arguments;
        if (args.length > 1 && args[1] == node) {
          return true;
        }
      }
    }
    return false;
  }

  bool _isInException(AstNode node) {
    AstNode? current = node.parent;
    while (current != null) {
      if (current is ThrowExpression) {
        return true;
      }
      if (current is InstanceCreationExpression) {
        final type = current.staticType;
        if (type != null) {
          final typeName = type.getDisplayString();
          // Common exception types
          if (typeName.endsWith('Exception') ||
              typeName.endsWith('Error') ||
              typeName == 'StateError' ||
              typeName == 'ArgumentError') {
            return true;
          }
        }
      }
      current = current.parent;
    }
    return false;
  }

  bool _isInKeyConstructor(AstNode node) {
    AstNode? current = node.parent;
    while (current != null) {
      if (current is InstanceCreationExpression) {
        final type = current.staticType;
        if (type != null) {
          final typeName = type.getDisplayString();
          if (typeName.contains('Key') || typeName == 'GlobalKey') {
            return true;
          }
        }
      }
      current = current.parent;
    }
    return false;
  }

  bool _isRegExpPattern(AstNode node) {
    final parent = node.parent;
    if (parent is ArgumentList) {
      final grandParent = parent.parent;
      if (grandParent is InstanceCreationExpression) {
        final type = grandParent.staticType;
        if (type != null && type.getDisplayString() == 'RegExp') {
          return true;
        }
      }
    }
    return false;
  }

  bool _isStringMethodArgument(AstNode node) {
    final parent = node.parent;
    if (parent is ArgumentList) {
      final grandParent = parent.parent;
      if (grandParent is MethodInvocation) {
        final target = grandParent.target;
        if (target != null && target.staticType?.isDartCoreString == true) {
          // String methods like contains, startsWith, endsWith, etc.
          final methodName = grandParent.methodName.name;
          const stringMethods = [
            'contains',
            'startsWith',
            'endsWith',
            'replaceAll',
            'replaceFirst',
            'split',
          ];
          return stringMethods.contains(methodName);
        }
      }
    }
    return false;
  }
}
