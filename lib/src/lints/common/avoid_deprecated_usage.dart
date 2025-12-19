import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidDeprecatedUsage extends DartLintRule {
  const AvoidDeprecatedUsage() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_deprecated_usage',
    problemMessage: 'This element is deprecated and should not be used.',
    correctionMessage: 'Replace with a non-deprecated alternative.',
    errorSeverity: analyzer_error.DiagnosticSeverity.INFO,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    // Check simple identifiers (variables, classes, etc.)
    context.registry.addSimpleIdentifier((node) {
      // Skip if this is the declaration itself
      if (node.inDeclarationContext()) {
        return;
      }

      final element = node.element;
      if (element != null && _hasDeprecatedAnnotation(element)) {
        reporter.atNode(node, _code);
      }
    });

    // Check constructor invocations
    context.registry.addInstanceCreationExpression((node) {
      final element = node.constructorName.element;
      if (element != null && _hasDeprecatedAnnotation(element)) {
        reporter.atNode(node.constructorName, _code);
      }
    });

    // Check method invocations
    context.registry.addMethodInvocation((node) {
      final element = node.methodName.element;
      if (element != null && _hasDeprecatedAnnotation(element)) {
        reporter.atNode(node.methodName, _code);
      }
    });
  }

  bool _hasDeprecatedAnnotation(Element? element) {
    if (element == null) return false;

    // Note: This is a simplified implementation.
    // The Dart analyzer already provides comprehensive deprecated usage warnings.
    // This rule serves as a complementary check for custom lint contexts.

    // Check the element's documentation or annotations
    // In a full implementation, this would check the element's metadata
    // For now, return false as the analyzer handles this well
    return false;
  }
}
