import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferAsyncCallback extends DartLintRule {
  const PreferAsyncCallback() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_async_callback',
    problemMessage:
        'Prefer using AsyncCallback typedef instead of Future<void> Function().',
    correctionMessage:
        'Replace Future<void> Function() with AsyncCallback from dart:ui or flutter.',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addGenericFunctionType((node) {
      // Check if this is Future<void> Function()
      if (!_isFutureVoidFunctionWithNoParameters(node)) return;

      // Report the issue
      reporter.atNode(
        node,
        _code,
      );
    });
  }

  bool _isFutureVoidFunctionWithNoParameters(GenericFunctionType node) {
    // Check if there are no parameters
    final parameters = node.parameters;
    if (parameters.parameters.isNotEmpty) return false;

    // Check if the return type is Future<void>
    final returnType = node.returnType;
    if (returnType is! NamedType) return false;
    if (returnType.name2.toString() != 'Future') return false;

    // Check if Future has a type argument of void
    final typeArguments = returnType.typeArguments;
    if (typeArguments == null) return false;
    if (typeArguments.arguments.length != 1) return false;

    final typeArg = typeArguments.arguments.first;
    if (typeArg is! NamedType) return false;
    if (typeArg.name2.toString() != 'void') return false;

    return true;
  }
}
