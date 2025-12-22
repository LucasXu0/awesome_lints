import 'package:analyzer/dart/ast/ast.dart';

/// Utility class for checking if string literals should be excluded from
/// magic string detection.
///
/// This class encapsulates the logic for determining when a string literal
/// serves a legitimate purpose and shouldn't be flagged as a "magic string".
class StringExclusionRules {
  const StringExclusionRules();

  /// Default method names whose arguments should be ignored.
  static const defaultIgnoredInvocations = ['print', 'debugPrint'];

  /// String method names whose arguments are typically valid string literals.
  static const stringMethodNames = [
    'contains',
    'startsWith',
    'endsWith',
    'replaceAll',
    'replaceFirst',
    'split',
  ];

  /// Checks if a string literal is an argument to an ignored invocation.
  ///
  /// Returns `true` if the node is an argument to methods like `print()` or
  /// `debugPrint()` where string literals are expected and acceptable.
  bool isArgumentToIgnoredInvocation(AstNode node) {
    final parent = node.parent;
    if (parent is ArgumentList) {
      final grandParent = parent.parent;
      if (grandParent is MethodInvocation) {
        final methodName = grandParent.methodName.name;
        return defaultIgnoredInvocations.contains(methodName);
      }
      if (grandParent is FunctionExpressionInvocation) {
        final function = grandParent.function;
        if (function is SimpleIdentifier) {
          return defaultIgnoredInvocations.contains(function.name);
        }
      }
    }
    return false;
  }

  /// Checks if a string literal is used as an assert message.
  ///
  /// Returns `true` if the node is the message argument (second argument)
  /// of an assert statement.
  bool isAssertMessage(AstNode node) {
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

  /// Checks if a string literal is used in an exception context.
  ///
  /// Returns `true` if the node is:
  /// - Inside a throw expression
  /// - An argument to an Exception or Error constructor
  bool isInException(AstNode node) {
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

  /// Checks if a string literal is used in a Key constructor.
  ///
  /// Returns `true` if the node is an argument to a constructor with "Key"
  /// in its type name (e.g., GlobalKey, ValueKey, ObjectKey).
  bool isInKeyConstructor(AstNode node) {
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

  /// Checks if a string literal is a RegExp pattern.
  ///
  /// Returns `true` if the node is an argument to a RegExp constructor.
  bool isRegExpPattern(AstNode node) {
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

  /// Checks if a string literal is an argument to a String method.
  ///
  /// Returns `true` if the node is an argument to methods like `contains()`,
  /// `startsWith()`, `endsWith()`, etc., where string literals are expected.
  bool isStringMethodArgument(AstNode node) {
    final parent = node.parent;
    if (parent is ArgumentList) {
      final grandParent = parent.parent;
      if (grandParent is MethodInvocation) {
        final target = grandParent.target;
        if (target != null && target.staticType?.isDartCoreString == true) {
          final methodName = grandParent.methodName.name;
          return stringMethodNames.contains(methodName);
        }
      }
    }
    return false;
  }

  /// Checks if any exclusion rule applies to the given node.
  ///
  /// Returns `true` if the node matches any of the exclusion rules:
  /// - Argument to ignored invocation
  /// - Assert message
  /// - In exception context
  /// - In Key constructor
  /// - RegExp pattern
  /// - String method argument
  bool shouldExclude(AstNode node) {
    return isArgumentToIgnoredInvocation(node) ||
        isAssertMessage(node) ||
        isInException(node) ||
        isInKeyConstructor(node) ||
        isRegExpPattern(node) ||
        isStringMethodArgument(node);
  }
}
