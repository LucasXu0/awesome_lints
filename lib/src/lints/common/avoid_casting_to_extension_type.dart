import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidCastingToExtensionType extends DartLintRule {
  const AvoidCastingToExtensionType() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_casting_to_extension_type',
    problemMessage:
        'Avoid casting to extension types as it may fail at runtime.',
    correctionMessage:
        'Use direct instantiation of the extension type instead of casting: ExtensionType(value)',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addAsExpression((node) {
      final typeAnnotation = node.type;

      // Check if the type annotation is a NamedType
      if (typeAnnotation is! NamedType) return;

      // Get the actual DartType from the type annotation
      final dartType = typeAnnotation.type;
      if (dartType == null) return;

      // Check if it's an extension type by comparing with its erasure
      // Extension types have a different type than their erasure
      final erasure = dartType.extensionTypeErasure;
      if (dartType != erasure) {
        // This is an extension type
        reporter.atNode(
          node,
          _code,
        );
      }
    });
  }
}
