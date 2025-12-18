import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferDedicatedMediaQueryMethods extends DartLintRule {
  const PreferDedicatedMediaQueryMethods() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_dedicated_media_query_methods',
    problemMessage:
        'Prefer using dedicated MediaQuery methods (like sizeOf, highContrastOf) instead of of() or maybeOf().',
    correctionMessage:
        'Use specific MediaQuery methods such as sizeOf(), highContrastOf(), platformBrightnessOf(), etc. These methods only rebuild when the specific property changes, improving performance.',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  static const _deprecatedMethods = {'of', 'maybeOf'};

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodInvocation((node) {
      // Check if it's one of the deprecated methods
      final methodName = node.methodName.name;
      if (!_deprecatedMethods.contains(methodName)) return;

      // Check if it's a MediaQuery method call by examining the target
      if (!_isMediaQueryMethod(node)) return;

      // Report the issue
      reporter.atNode(
        node,
        _code,
      );
    });
  }

  /// Check if the method invocation is on MediaQuery
  bool _isMediaQueryMethod(MethodInvocation node) {
    final target = node.target;
    if (target == null) return false;

    // Check if the target is a SimpleIdentifier named 'MediaQuery'
    if (target is SimpleIdentifier && target.name == 'MediaQuery') {
      return true;
    }

    // Check if it's a prefixed identifier (e.g., widgets.MediaQuery)
    if (target is PrefixedIdentifier &&
        target.identifier.name == 'MediaQuery') {
      return true;
    }

    return false;
  }
}
