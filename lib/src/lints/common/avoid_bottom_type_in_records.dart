import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidBottomTypeInRecords extends DartLintRule {
  const AvoidBottomTypeInRecords() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_bottom_type_in_records',
    problemMessage:
        'Avoid using bottom types (void, Never, Null) in record type declarations.',
    correctionMessage:
        'Use appropriate types instead of bottom types. For void, consider Future<void>. For Null, use nullable types.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  static const _bottomTypeNames = {'void', 'Never', 'Null'};

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addRecordTypeAnnotation((node) {
      // Check positional fields
      for (final field in node.positionalFields) {
        _checkTypeAnnotation(field.type, reporter);
      }

      // Check named fields
      if (node.namedFields != null) {
        for (final field in node.namedFields!.fields) {
          _checkTypeAnnotation(field.type, reporter);
        }
      }
    });
  }

  void _checkTypeAnnotation(TypeAnnotation type, DiagnosticReporter reporter) {
    if (type is NamedType) {
      final typeName = type.name.lexeme;
      if (_bottomTypeNames.contains(typeName)) {
        reporter.atNode(type, _code);
      }
    }
  }
}
