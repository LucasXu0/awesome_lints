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
      if (node.isSet) {
        _checkDuplicates(node.elements, reporter);
      } else if (node.isMap) {
        _checkMapDuplicates(node.elements, reporter);
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
        return true;
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
      if (expr is SimpleIdentifier) {
        return 'spread:${expr.name}';
      }
      return 'spread:${_getExpressionKey(expr)}';
    }

    // Handle if elements
    if (element is IfElement) {
      final condition = _getExpressionKey(element.expression);
      final thenKey = _getElementKey(element.thenElement);
      return 'if:$condition:$thenKey';
    }

    // Handle regular expressions
    if (element is Expression) {
      return _getExpressionKey(element);
    }

    return null;
  }

  String? _getExpressionKey(Expression expr) {
    if (expr is IntegerLiteral) {
      return 'int:${expr.value}';
    }
    if (expr is StringLiteral) {
      return 'string:"${expr.stringValue}"';
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
      return 'id:${expr.identifier.name}';
    }
    // For complex expressions, generate a unique representation
    return 'expr:${expr.toString()}';
  }
}
