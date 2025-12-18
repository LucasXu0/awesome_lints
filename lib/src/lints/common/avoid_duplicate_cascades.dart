import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidDuplicateCascades extends DartLintRule {
  const AvoidDuplicateCascades() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_duplicate_cascades',
    problemMessage:
        'This cascade operation is duplicated, which is likely a typo or bug.',
    correctionMessage: 'Remove or modify the duplicate cascade operation.',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addCascadeExpression((node) {
      final sections = node.cascadeSections;
      final seen = <String>{};

      for (final section in sections) {
        final key = _getCascadeKey(section);
        if (key != null) {
          if (seen.contains(key)) {
            reporter.atNode(
              section,
              _code,
            );
          } else {
            seen.add(key);
          }
        }
      }
    });
  }

  String? _getCascadeKey(Expression section) {
    // Assignment expressions (e.g., ..field = value)
    if (section is AssignmentExpression) {
      final left = section.leftHandSide;
      if (left is PropertyAccess) {
        return 'assign:${left.propertyName.name}';
      }
      if (left is IndexExpression) {
        final index = _getIndexKey(left.index);
        if (index != null) {
          return 'index:$index';
        }
      }
    }

    // Method invocations (e.g., ..method())
    if (section is MethodInvocation) {
      final methodName = section.methodName.name;
      final args = _getArgumentsKey(section.argumentList);
      return 'method:$methodName($args)';
    }

    // Property access (e.g., ..property)
    if (section is PropertyAccess) {
      return 'property:${section.propertyName.name}';
    }

    // Index expressions (e.g., ..[0])
    if (section is IndexExpression) {
      final index = _getIndexKey(section.index);
      if (index != null) {
        return 'index:$index';
      }
    }

    return null;
  }

  String? _getIndexKey(Expression index) {
    if (index is IntegerLiteral) {
      return index.value.toString();
    }
    if (index is StringLiteral) {
      return '"${index.stringValue}"';
    }
    return null;
  }

  String _getArgumentsKey(ArgumentList argumentList) {
    return argumentList.arguments.map((arg) {
      if (arg is NamedExpression) {
        return '${arg.name.label.name}:${_getExpressionKey(arg.expression)}';
      }
      return _getExpressionKey(arg);
    }).join(',');
  }

  String _getExpressionKey(Expression expr) {
    if (expr is IntegerLiteral) {
      return expr.value.toString();
    }
    if (expr is StringLiteral) {
      return '"${expr.stringValue}"';
    }
    if (expr is BooleanLiteral) {
      return expr.value.toString();
    }
    if (expr is NullLiteral) {
      return 'null';
    }
    // For complex expressions, use a generic marker
    return '_';
  }
}
