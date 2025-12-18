import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidAccessingCollectionsByConstantIndex extends DartLintRule {
  const AvoidAccessingCollectionsByConstantIndex() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_accessing_collections_by_constant_index',
    problemMessage:
        'Avoid accessing collection elements by constant index inside a loop.',
    correctionMessage:
        'Use the loop variable as index or move the access outside the loop.',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addForStatement((node) {
      _checkLoop(node.body, reporter);
    });

    context.registry.addWhileStatement((node) {
      _checkLoop(node.body, reporter);
    });

    context.registry.addDoStatement((node) {
      _checkLoop(node.body, reporter);
    });
  }

  void _checkLoop(Statement body, ErrorReporter reporter) {
    final visitor = _ConstantIndexAccessVisitor();
    body.visitChildren(visitor);

    for (final indexAccess in visitor.constantIndexAccesses) {
      reporter.atNode(
        indexAccess,
        _code,
      );
    }
  }
}

class _ConstantIndexAccessVisitor extends RecursiveAstVisitor<void> {
  final List<IndexExpression> constantIndexAccesses = [];

  @override
  void visitIndexExpression(IndexExpression node) {
    final index = node.index;

    // Check if the index is a constant or final field
    if (_isConstantOrFinal(index)) {
      constantIndexAccesses.add(node);
    }

    super.visitIndexExpression(node);
  }

  bool _isConstantOrFinal(Expression expression) {
    // Check for integer literals
    if (expression is IntegerLiteral) {
      return true;
    }

    // Check for simple identifiers that are const or final
    if (expression is SimpleIdentifier) {
      final element = expression.element;
      if (element is VariableElement2) {
        return element.isConst ||
            element.isFinal ||
            element.isStatic && element.isFinal;
      }
    }

    // Check for prefixed identifiers (e.g., ClassName.staticFinal)
    if (expression is PrefixedIdentifier) {
      final element = expression.element;
      if (element is VariableElement2) {
        return element.isConst ||
            element.isFinal ||
            element.isStatic && element.isFinal;
      }
    }

    // Check for property access (e.g., object.constantField)
    if (expression is PropertyAccess) {
      final element = expression.propertyName.element;
      if (element is VariableElement2) {
        return element.isConst ||
            element.isFinal ||
            element.isStatic && element.isFinal;
      }
    }

    return false;
  }
}
