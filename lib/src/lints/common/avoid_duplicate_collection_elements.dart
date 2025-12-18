import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidDuplicateCollectionElements extends DartLintRule {
  const AvoidDuplicateCollectionElements() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_duplicate_collection_elements',
    problemMessage:
        'This collection contains duplicate elements, which is likely a typo or bug.',
    correctionMessage: 'Remove duplicate elements from the collection.',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addListLiteral((node) {
      _checkDuplicates(node.elements, reporter);
    });

    context.registry.addSetOrMapLiteral((node) {
      // Check if it's a map by looking for MapLiteralEntry elements
      final hasMapEntry = node.elements.any((e) => e is MapLiteralEntry);

      if (hasMapEntry || node.isMap) {
        _checkMapDuplicates(node.elements, reporter);
      } else {
        // If no map entries, treat it as a set (even if isSet is false due to lack of type resolution)
        _checkDuplicates(node.elements, reporter);
      }
    });
  }

  void _checkDuplicates(
    NodeList<CollectionElement> elements,
    ErrorReporter reporter,
  ) {
    final seen = <String>{};

    for (final element in elements) {
      final key = _getElementKey(element);
      if (key != null) {
        if (seen.contains(key)) {
          // Skip if this is inside a function callback (like .expand(), .map())
          // as duplicates might be intentional
          if (!_isInsideFunctionCallback(element)) {
            reporter.atNode(
              element,
              _code,
            );
          }
        } else {
          seen.add(key);
        }
      }
    }
  }

  bool _isInsideFunctionCallback(CollectionElement element) {
    var parent = element.parent;
    while (parent != null) {
      // Check if we're inside a function expression (lambda/callback)
      if (parent is FunctionExpression) {
        // Need to distinguish between regular function declarations
        // and anonymous functions/callbacks
        final grandparent = parent.parent;
        // If the parent is a FunctionDeclaration or MethodDeclaration,
        // this is a regular function, not a callback
        if (grandparent is! FunctionDeclaration &&
            grandparent is! MethodDeclaration) {
          return true;
        }
      }
      parent = parent.parent;
    }
    return false;
  }

  void _checkMapDuplicates(
    NodeList<CollectionElement> elements,
    ErrorReporter reporter,
  ) {
    final seen = <String>{};

    for (final element in elements) {
      if (element is MapLiteralEntry) {
        final key = _getExpressionKey(element.key);
        if (key != null) {
          if (seen.contains(key)) {
            reporter.atNode(
              element,
              _code,
            );
          } else {
            seen.add(key);
          }
        }
      }
    }
  }

  String? _getElementKey(CollectionElement element) {
    // Handle spread operators
    if (element is SpreadElement) {
      final expr = element.expression;
      final exprKey = expr is SimpleIdentifier
          ? 'id:${expr.name}'
          : _getExpressionKey(expr);
      if (exprKey == null) return null;
      return 'spread:$exprKey';
    }

    // Handle if elements
    if (element is IfElement) {
      final expression = element.expression;
      final thenElement = element.thenElement;
      final exprKey = _getExpressionKey(expression);
      final thenKey = _getElementKey(thenElement);
      if (exprKey == null || thenKey == null) {
        return null;
      }
      return 'if:$exprKey:$thenKey';
    }

    // Handle regular expressions
    if (element is Expression) {
      return _getExpressionKey(element);
    }

    return null;
  }

  String? _getExpressionKey(Expression? expr) {
    if (expr == null) return null;

    if (expr is IntegerLiteral) {
      return 'int:${expr.value}';
    }
    if (expr is StringLiteral) {
      return 'string:"${expr.stringValue}"';
    }
    if (expr is DoubleLiteral) {
      return 'double:${expr.value}';
    }
    if (expr is BooleanLiteral) {
      return 'bool:${expr.value}';
    }
    if (expr is NullLiteral) {
      return 'null';
    }
    if (expr is SimpleIdentifier) {
      return 'id:${expr.name}';
    }
    if (expr is PrefixedIdentifier) {
      return 'id:${expr.prefix.name}.${expr.identifier.name}';
    }
    if (expr is PropertyAccess) {
      // Handle property access like list.isNotEmpty
      final target = expr.target;
      final property = expr.propertyName.name;
      final targetKey = target != null ? _getExpressionKey(target) : 'null';
      return 'prop:$targetKey.$property';
    }
    // For complex expressions, generate a unique representation
    return 'expr:${expr.toString()}';
  }
}
