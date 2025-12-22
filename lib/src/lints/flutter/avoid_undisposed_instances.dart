import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import '../../utils/disposal_utils.dart';

class AvoidUndisposedInstances extends DartLintRule {
  const AvoidUndisposedInstances() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_undisposed_instances',
    problemMessage:
        'Avoid creating disposable instances that are not disposed.',
    correctionMessage:
        'Assign the instance to a variable and dispose it later (e.g. in the dispose method).',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      final type = node.staticType;
      if (type == null) return;

      // Check if the type has a disposal method (dispose, close, or cancel)
      if (!DisposalUtils.hasDisposalMethod(type)) return;

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
}
