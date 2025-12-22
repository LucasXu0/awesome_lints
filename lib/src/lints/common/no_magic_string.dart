import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as analyzer_error;
import 'package:custom_lint_builder/custom_lint_builder.dart';

import '../../utils/string_exclusion_rules.dart';
import 'base/magic_value_lint.dart';

class NoMagicString extends MagicValueLint {
  const NoMagicString() : super(code: _code);

  static const _code = LintCode(
    name: 'no_magic_string',
    problemMessage:
        'Avoid using magic strings. Extract them into named constants for better maintainability and localization.',
    correctionMessage:
        'Define a named constant with a descriptive name for this string.',
    errorSeverity: analyzer_error.DiagnosticSeverity.WARNING,
  );

  static const _exclusionRules = StringExclusionRules();

  @override
  bool isAllowedValue(Literal node) {
    // Don't report empty strings
    if (node is SimpleStringLiteral && node.value.isEmpty) {
      return true;
    }
    return false;
  }

  @override
  bool shouldCheckLiteral(Literal node) {
    return node is SimpleStringLiteral;
  }

  @override
  void registerLiteralChecks(
    CustomLintContext context,
    void Function(Literal) checkLiteral,
  ) {
    context.registry.addSimpleStringLiteral((node) => checkLiteral(node));
  }

  @override
  bool hasCustomExclusion(Literal node) {
    return _exclusionRules.shouldExclude(node);
  }
}
