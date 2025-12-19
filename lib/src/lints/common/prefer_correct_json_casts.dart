import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferCorrectJsonCasts extends DartLintRule {
  const PreferCorrectJsonCasts() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_correct_json_casts',
    problemMessage:
        'Avoid direct casts to Map or List with type arguments as they may fail at runtime.',
    correctionMessage:
        'Use cast() method instead: cast the value to the base type first (as Map<String, Object?> or as List<Object?>), then call .cast<K, V>() or .cast<T>()',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addAsExpression((node) {
      final typeAnnotation = node.type;

      // Check if the type annotation is a NamedType
      if (typeAnnotation is! NamedType) return;

      final typeName = typeAnnotation.name.lexeme;

      // Check if it's a Map or List cast
      if (typeName != 'Map' && typeName != 'List') return;

      // Check if the type has type arguments
      final typeArguments = typeAnnotation.typeArguments;
      if (typeArguments == null || typeArguments.arguments.isEmpty) return;

      // This is a direct cast to Map<K, V> or List<T> which is problematic
      reporter.atNode(node, _code);
    });
  }
}
