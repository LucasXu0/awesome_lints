import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferVoidCallback extends DartLintRule {
  const PreferVoidCallback() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_void_callback',
    problemMessage:
        'Prefer using VoidCallback typedef instead of void Function().',
    correctionMessage:
        'Replace void Function() with VoidCallback from dart:ui or flutter.',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addGenericFunctionType((node) {
      // Check if this is void Function()
      if (!_isVoidFunctionWithNoParameters(node)) return;

      // Report the issue
      reporter.atNode(
        node,
        _code,
      );
    });
  }

  bool _isVoidFunctionWithNoParameters(GenericFunctionType node) {
    // Check if the return type is void
    final returnType = node.returnType;
    if (returnType is! NamedType) return false;
    if (returnType.name2.toString() != 'void') return false;

    // Check if there are no parameters
    final parameters = node.parameters;
    if (parameters.parameters.isNotEmpty) return false;

    return true;
  }
}
