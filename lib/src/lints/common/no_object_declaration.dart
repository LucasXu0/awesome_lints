import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class NoObjectDeclaration extends DartLintRule {
  const NoObjectDeclaration() : super(code: _code);

  static const _code = LintCode(
    name: 'no_object_declaration',
    problemMessage:
        'Avoid declaring class members with the Object type. Use a more specific type instead.',
    correctionMessage:
        'Replace Object with a more specific type that better describes the member.',
    errorSeverity: analyzer_error.ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    // Check field declarations
    context.registry.addFieldDeclaration((node) {
      final type = node.fields.type;
      if (_isObjectType(type)) {
        reporter.atNode(type!, _code);
      }
    });

    // Check method declarations (return type)
    context.registry.addMethodDeclaration((node) {
      // Skip if it's a setter (no return type)
      if (node.isSetter) {
        return;
      }

      final returnType = node.returnType;
      if (_isObjectType(returnType)) {
        reporter.atNode(returnType!, _code);
      }
    });
  }

  /// Checks if the given type annotation represents the Object type.
  bool _isObjectType(TypeAnnotation? type) {
    if (type == null) {
      return false;
    }

    // Handle NamedType (previously known as TypeName)
    if (type is NamedType) {
      final name = type.name2;
      // Check if it's exactly "Object" (not nullable Object?)
      if (name.lexeme == 'Object') {
        return true;
      }
    }

    return false;
  }
}
