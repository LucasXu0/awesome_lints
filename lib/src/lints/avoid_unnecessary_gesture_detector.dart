import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidUnnecessaryGestureDetector extends DartLintRule {
  const AvoidUnnecessaryGestureDetector() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_unnecessary_gesture_detector',
    problemMessage: 'Avoid using GestureDetector without any callbacks.',
    correctionMessage:
        'Add a callback (e.g. onTap) or remove the GestureDetector.',
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

      // Check if it is a GestureDetector
      // We check the name. checking type element is safer but name is faster and usually sufficient for this specific widget name.
      // But let's try to check type name safely.
      if (type.element3?.name3 != 'GestureDetector') return;

      // Also check if it's from flutter/widgets.dart or similar?
      // Checking name is usually fine for "GestureDetector".

      // Check arguments for any "on..." named argument.
      final hasCallback = node.argumentList.arguments.any((arg) {
        if (arg is NamedExpression) {
          final name = arg.name.label.name;
          return name.startsWith('on');
        }
        return false;
      });

      if (!hasCallback) {
        reporter.atNode(node, _code);
      }
    });
  }
}
