import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferNullableProviderTypes extends DartLintRule {
  const PreferNullableProviderTypes() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_nullable_provider_types',
    problemMessage:
        'Prefer using nullable types with Provider access methods to handle missing values.',
    correctionMessage:
        'Add ? to the type parameter (e.g., context.watch<String?>() instead of context.watch<String>()).',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodInvocation((node) {
      if (!_isProviderAccessMethod(node)) return;

      final typeArguments = node.typeArguments;
      if (typeArguments == null || typeArguments.arguments.isEmpty) return;

      final typeArgument = typeArguments.arguments.first;
      if (!_isNullableType(typeArgument)) {
        reporter.atNode(typeArgument, _code);
      }
    });
  }

  bool _isProviderAccessMethod(MethodInvocation node) {
    final methodName = node.methodName.name;

    // Check for context.read() or context.watch()
    if (methodName == 'read' ||
        methodName == 'watch' ||
        methodName == 'select') {
      return true;
    }

    // Check for Provider.of()
    if (methodName == 'of') {
      final target = node.target;
      if (target == null) return false;

      final targetName = target is SimpleIdentifier
          ? target.name
          : target is PrefixedIdentifier
          ? target.identifier.name
          : null;

      return targetName == 'Provider';
    }

    return false;
  }

  bool _isNullableType(TypeAnnotation typeAnnotation) {
    // Check if type annotation has a '?' suffix indicating nullability
    if (typeAnnotation is NamedType) {
      return typeAnnotation.question != null;
    }
    return false;
  }
}
