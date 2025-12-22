import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import '../../../utils/ast_extensions.dart';

/// Base class for lints that detect "magic" literal values.
///
/// Subclasses should implement methods to specify which literal types to check
/// and what values are allowed. This base class provides common exclusion logic
/// for literals that appear in const/final declarations, default parameters,
/// and annotations.
///
/// Example usage:
/// ```dart
/// class NoMagicNumber extends MagicValueLint {
///   const NoMagicNumber() : super(code: _code);
///
///   @override
///   bool isAllowedValue(Literal node) {
///     if (node is IntegerLiteral) {
///       return [-1, 0, 1].contains(node.value);
///     }
///     return false;
///   }
///
///   @override
///   bool shouldCheckLiteral(Literal node) {
///     return node is IntegerLiteral || node is DoubleLiteral;
///   }
///
///   @override
///   void registerLiteralChecks(CustomLintContext context, void Function(Literal) checkLiteral) {
///     context.registry.addIntegerLiteral(checkLiteral);
///     context.registry.addDoubleLiteral(checkLiteral);
///   }
/// }
/// ```
abstract class MagicValueLint extends DartLintRule {
  /// Creates a new magic value lint with the given [code].
  const MagicValueLint({required super.code});

  /// Checks if the given literal value is allowed and should not trigger the lint.
  ///
  /// For example, numbers like 0, 1, -1 or empty strings might be allowed.
  bool isAllowedValue(Literal node);

  /// Checks if the given literal should be analyzed by this lint.
  ///
  /// For example, a number lint would return true for IntegerLiteral and DoubleLiteral,
  /// while a string lint would return true for SimpleStringLiteral.
  bool shouldCheckLiteral(Literal node);

  /// Registers the literal node types that this lint should check.
  ///
  /// For example:
  /// ```dart
  /// context.registry.addIntegerLiteral(checkLiteral);
  /// context.registry.addDoubleLiteral(checkLiteral);
  /// ```
  void registerLiteralChecks(
    CustomLintContext context,
    void Function(Literal) checkLiteral,
  );

  /// Additional custom exclusion logic specific to the subclass.
  ///
  /// Override this to add lint-specific exclusions beyond the common ones
  /// (const/final, default params, annotations).
  ///
  /// Return `true` if the node should be excluded from reporting.
  bool hasCustomExclusion(Literal node) => false;

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    registerLiteralChecks(context, (node) {
      if (_shouldReport(node)) {
        reporter.atNode(node, code);
      }
    });
  }

  bool _shouldReport(Literal node) {
    // Only check literals we're interested in
    if (!shouldCheckLiteral(node)) {
      return false;
    }

    // Check if the value is in the allowed list
    if (isAllowedValue(node)) {
      return false;
    }

    // Common exclusions (now using extension methods)

    // Don't report if it's part of a variable declaration with const/final
    if (node.isPartOfConstOrFinalDeclaration()) {
      return false;
    }

    // Don't report if it's a default parameter value
    if (node.isDefaultParameterValue()) {
      return false;
    }

    // Don't report if it's in an annotation
    if (node.isInAnnotation()) {
      return false;
    }

    // Check for custom exclusions specific to the subclass
    if (hasCustomExclusion(node)) {
      return false;
    }

    return true;
  }
}
