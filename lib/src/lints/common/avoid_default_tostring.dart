import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidDefaultTostring extends DartLintRule {
  const AvoidDefaultTostring() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_default_tostring',
    problemMessage:
        'Avoid calling toString() on a class without a custom toString() implementation.',
    correctionMessage:
        'Implement a custom toString() method or use a different approach.',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    // Check explicit toString() calls
    context.registry.addMethodInvocation((node) {
      if (node.methodName.name == 'toString' &&
          node.argumentList.arguments.isEmpty) {
        final targetType = node.realTarget?.staticType;
        if (targetType != null && !_hasCustomToString(targetType.element3)) {
          reporter.atNode(
            node.methodName,
            _code,
          );
        }
      }
    });

    // Check string interpolation
    context.registry.addInterpolationExpression((node) {
      final expression = node.expression;
      final type = expression.staticType;
      if (type != null && !_hasCustomToString(type.element3)) {
        reporter.atNode(
          expression,
          _code,
        );
      }
    });
  }

  bool _hasCustomToString(Element2? element) {
    if (element == null) return false;

    final name = element.displayName;

    // Primitive types and String have built-in toString
    if (name == 'String' ||
        name == 'int' ||
        name == 'double' ||
        name == 'bool' ||
        name == 'num' ||
        name == 'Null') {
      return true;
    }

    // Collection types have built-in toString
    if (name == 'List' ||
        name == 'Set' ||
        name == 'Map' ||
        name == 'Iterable' ||
        name == 'Queue' ||
        name == 'LinkedHashSet' ||
        name == 'LinkedHashMap' ||
        name == 'HashMap' ||
        name == 'HashSet') {
      return true;
    }

    // Core Dart types with proper toString
    if (name == 'DateTime' ||
        name == 'Duration' ||
        name == 'Uri' ||
        name == 'RegExp' ||
        name == 'StackTrace' ||
        name == 'Symbol' ||
        name == 'Type' ||
        name == 'Future' ||
        name == 'Stream') {
      return true;
    }

    // Check if the class has a custom toString implementation
    if (element is InterfaceElement2) {
      for (final method in element.methods2) {
        if (method.displayName == 'toString') {
          // Check if it's not just inherited from Object
          final enclosingElement = method.enclosingElement2;
          if (enclosingElement?.displayName != 'Object') {
            return true;
          }
        }
      }
    }

    return false;
  }
}
