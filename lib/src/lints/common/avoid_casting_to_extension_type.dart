import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
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
      final type = node.type;

      // Check if the type is a NamedType
      if (type is! NamedType) return;

      // Get the element for the type
      final element = type.element2;

      // Check if the element kind is an extension type
      if (element?.kind == ElementKind.EXTENSION_TYPE) {
        reporter.atNode(
          node,
          _code,
        );
      }
    });
  }
}
