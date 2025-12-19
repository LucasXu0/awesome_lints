import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidBottomTypeInPatterns extends DartLintRule {
  const AvoidBottomTypeInPatterns() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_bottom_type_in_patterns',
    problemMessage:
        'Avoid using bottom types (void, Never, Null) in pattern matching.',
    correctionMessage:
        'Use null checks (== null) or wildcard patterns instead of bottom type patterns.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  static const _bottomTypeNames = {'void', 'Never', 'Null'};

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addObjectPattern((node) {
      _checkTypeAnnotation(node.type, reporter);
    });

    context.registry.addWildcardPattern((node) {
      final type = node.type;
      if (type != null) {
        _checkTypeAnnotation(type, reporter);
      }
    });

    context.registry.addDeclaredVariablePattern((node) {
      final type = node.type;
      if (type != null) {
        _checkTypeAnnotation(type, reporter);
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
