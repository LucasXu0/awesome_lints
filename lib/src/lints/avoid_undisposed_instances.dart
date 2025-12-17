import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidUndisposedInstances extends DartLintRule {
  const AvoidUndisposedInstances() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_undisposed_instances',
    problemMessage:
        'Avoid creating disposable instances that are not disposed.',
    correctionMessage:
        'Assign the instance to a variable and dispose it later (e.g. in the dispose method).',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      final type = node.staticType;
      if (type == null) return;

      // Check if the type has a dispose method
      if (!_hasDisposeMethod(type)) return;

      var parent = node.parent;

      // Unwrap ParenthesizedExpression, AsExpression, etc.
      while (parent is ParenthesizedExpression ||
          parent is AsExpression ||
          parent is ConditionalExpression) {
        parent = parent?.parent;
      }

      // Check for named argument wrapper
      if (parent is NamedExpression) {
        parent = parent.parent;
      }

      if (parent is ArgumentList) {
        // It is passed as an argument.
        reporter.atNode(node, _code);
      } else if (parent is ExpressionStatement) {
        // Just created and ignored
        reporter.atNode(node, _code);
      }
    });
  }

  bool _hasDisposeMethod(DartType type) {
    if (type is! InterfaceType) return false;

    // Check current class and superclasses
    var current = type;
    while (true) {
      if (current.methods2.any((m) => m.name3 == 'dispose')) {
        return true;
      }
      final superType = current.superclass;
      if (superType == null) break;
      current = superType;
    }
    return false;
  }
}
