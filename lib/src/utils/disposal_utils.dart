import 'package:analyzer/dart/element/type.dart';

/// Utility class for checking if types have disposal methods.
///
/// Provides shared logic for detecting disposable types across multiple lints.
class DisposalUtils {
  DisposalUtils._();

  /// Common disposal method names to check for.
  static const disposalMethods = {'dispose', 'close', 'cancel'};

  /// Checks if the given [type] has any disposal method (dispose, close, or cancel).
  ///
  /// Uses [InterfaceType.lookUpMethod] to search through the entire class hierarchy,
  /// including superclasses and mixins.
  ///
  /// Returns `true` if any disposal method is found, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// final type = node.declaredElement?.type;
  /// if (type != null && DisposalUtils.hasDisposalMethod(type)) {
  ///   // Type needs disposal
  /// }
  /// ```
  static bool hasDisposalMethod(DartType type) {
    if (type is! InterfaceType) return false;

    // Use lookUpMethod for efficient hierarchy traversal
    for (final methodName in disposalMethods) {
      final method = type.lookUpMethod(methodName, type.element.library);
      if (method != null) {
        return true;
      }
    }

    return false;
  }

  /// Checks if the given [type] has a specific disposal [methodName].
  ///
  /// Useful when you need to check for a specific disposal method.
  ///
  /// Example:
  /// ```dart
  /// if (DisposalUtils.hasSpecificDisposalMethod(type, 'dispose')) {
  ///   // Type has dispose method specifically
  /// }
  /// ```
  static bool hasSpecificDisposalMethod(DartType type, String methodName) {
    if (type is! InterfaceType) return false;
    return type.lookUpMethod(methodName, type.element.library) != null;
  }

  /// Checks if the given [type] has any of the specified [methodNames].
  ///
  /// More flexible version that allows checking for custom method names.
  ///
  /// Example:
  /// ```dart
  /// if (DisposalUtils.hasAnyMethod(type, {'cleanup', 'destroy'})) {
  ///   // Type has cleanup or destroy method
  /// }
  /// ```
  static bool hasAnyMethod(DartType type, Iterable<String> methodNames) {
    if (type is! InterfaceType) return false;

    for (final methodName in methodNames) {
      final method = type.lookUpMethod(methodName, type.element.library);
      if (method != null) {
        return true;
      }
    }

    return false;
  }
}
