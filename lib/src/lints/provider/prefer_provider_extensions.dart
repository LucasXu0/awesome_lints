import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferProviderExtensions extends DartLintRule {
  const PreferProviderExtensions() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_provider_extensions',
    problemMessage:
        'Prefer using context.read() or context.watch() instead of Provider.of().',
    correctionMessage:
        'Use context.watch() for reactive updates or context.read() for one-time access.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodInvocation((node) {
      if (_isProviderOf(node)) {
        reporter.atNode(node, _code);
      }
    });
  }

  bool _isProviderOf(MethodInvocation node) {
    // Check if the method name is 'of'
    if (node.methodName.name != 'of') return false;

    // Check if the target is 'Provider'
    final target = node.target;
    if (target == null) return false;

    // Handle both simple identifiers and prefixed identifiers
    final targetName = target is SimpleIdentifier
        ? target.name
        : target is PrefixedIdentifier
        ? target.identifier.name
        : null;

    return targetName == 'Provider';
  }
}
