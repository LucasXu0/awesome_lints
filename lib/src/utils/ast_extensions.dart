import 'package:analyzer/dart/ast/ast.dart';

/// Extension methods for easier AST node manipulation.
///
/// Provides convenient helpers to reduce boilerplate when working with AST nodes.
extension ArgumentListExtensions on ArgumentList {
  /// Gets a named argument by [name], or null if not found.
  ///
  /// This is a safer alternative to using `firstWhere` with a try-catch.
  ///
  /// Example:
  /// ```dart
  /// final childrenArg = node.argumentList.getNamedArgument('children');
  /// if (childrenArg != null) {
  ///   // Process children argument
  /// }
  /// ```
  NamedExpression? getNamedArgument(String name) {
    try {
      return arguments.whereType<NamedExpression>().firstWhere(
        (arg) => arg.name.label.name == name,
      );
    } catch (_) {
      return null;
    }
  }

  /// Gets all named arguments as a map of name to expression.
  ///
  /// Useful when you need to check multiple arguments at once.
  ///
  /// Example:
  /// ```dart
  /// final namedArgs = node.argumentList.namedArgumentsMap;
  /// final width = namedArgs['width'];
  /// final height = namedArgs['height'];
  /// ```
  Map<String, NamedExpression> get namedArgumentsMap {
    final map = <String, NamedExpression>{};
    for (final arg in arguments.whereType<NamedExpression>()) {
      map[arg.name.label.name] = arg;
    }
    return map;
  }

  /// Gets all positional arguments.
  ///
  /// Example:
  /// ```dart
  /// final positional = node.argumentList.positionalArguments;
  /// ```
  List<Expression> get positionalArguments {
    return arguments
        .where((arg) => arg is! NamedExpression)
        .cast<Expression>()
        .toList();
  }
}

/// Extension methods for extracting identifiers from expressions.
extension ExpressionExtensions on Expression {
  /// Extracts a simple identifier name from various expression types.
  ///
  /// Handles:
  /// - SimpleIdentifier: `fieldName`
  /// - PrefixedIdentifier with 'this': `this.fieldName`
  /// - PropertyAccess with ThisExpression: `this.fieldName`
  /// - PostfixExpression: `fieldName++`, `fieldName--`
  ///
  /// Returns null if the expression doesn't match these patterns.
  ///
  /// Example:
  /// ```dart
  /// final fieldName = expression.simpleIdentifierName;
  /// if (fieldName != null) {
  ///   // Process field access
  /// }
  /// ```
  String? get simpleIdentifierName {
    final self = this;

    if (self is SimpleIdentifier) {
      return self.name;
    }

    if (self is PrefixedIdentifier && self.prefix.name == 'this') {
      return self.identifier.name;
    }

    if (self is PropertyAccess && self.target is ThisExpression) {
      return self.propertyName.name;
    }

    if (self is PostfixExpression) {
      return self.operand.simpleIdentifierName;
    }

    return null;
  }

  /// Checks if this expression is a 'this' reference (ThisExpression or 'this' identifier).
  ///
  /// Example:
  /// ```dart
  /// if (target.isThisReference) {
  ///   // Expression refers to 'this'
  /// }
  /// ```
  bool get isThisReference {
    final self = this;
    return self is ThisExpression ||
        (self is SimpleIdentifier && self.name == 'this');
  }
}

/// Extension methods for method invocations.
extension MethodInvocationExtensions on MethodInvocation {
  /// Gets the target object name if it's a simple identifier.
  ///
  /// Example:
  /// ```dart
  /// // For: controller.dispose()
  /// final targetName = invocation.targetName; // 'controller'
  /// ```
  String? get targetName {
    return target?.simpleIdentifierName;
  }

  /// Checks if this is a method call on 'this' (implicit or explicit).
  ///
  /// Example:
  /// ```dart
  /// // Both match:
  /// // this.setState(...)
  /// // setState(...)
  /// if (invocation.isOnThis) {
  ///   // Method called on current instance
  /// }
  /// ```
  bool get isOnThis {
    final t = target;
    return t == null || t.isThisReference;
  }
}

/// Extension methods for list literals.
extension ListLiteralExtensions on ListLiteral {
  /// Gets all spread element expressions from the list.
  ///
  /// Example:
  /// ```dart
  /// // For: [...items, ...moreItems]
  /// final spreads = listLiteral.spreadExpressions; // [items, moreItems]
  /// ```
  List<Expression> get spreadExpressions {
    return elements
        .whereType<SpreadElement>()
        .map((e) => e.expression)
        .toList();
  }

  /// Checks if the list contains any spread elements.
  bool get hasSpreadElements {
    return elements.any((e) => e is SpreadElement);
  }

  /// Gets only the direct elements (non-spread).
  List<Expression> get directElements {
    return elements
        .where((e) => e is! SpreadElement)
        .cast<Expression>()
        .toList();
  }
}
