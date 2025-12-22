import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';

/// Caches expensive type operations for improved performance.
///
/// When analyzing code, lints often need to check type information repeatedly.
/// Operations like `getDisplayString()` can be expensive, especially when
/// called multiple times for the same types within a single file analysis.
///
/// This cache provides memoization for common type operations to reduce
/// redundant computations and improve analysis performance on large files.
///
/// Example usage:
/// ```dart
/// class MyLint extends DartLintRule {
///   @override
///   void run(
///     CustomLintResolver resolver,
///     DiagnosticReporter reporter,
///     CustomLintContext context,
///   ) {
///     final typeCache = TypeCache();
///
///     context.registry.addExpression((node) {
///       final type = node.staticType;
///       if (type == null) return;
///
///       // Use cached display string instead of calling getDisplayString() repeatedly
///       final typeName = typeCache.getDisplayString(type);
///       if (typeName == 'Widget') {
///         // Process widget type
///       }
///     });
///   }
/// }
/// ```
///
/// **Note:** The cache is designed to be used per-file. Create a new instance
/// for each file analysis to avoid memory growth.
class TypeCache {
  /// Creates a new type cache instance.
  TypeCache();

  final Map<DartType, String> _displayStrings = {};
  final Map<DartType, String> _displayStringsWithoutNullability = {};
  final Map<DartType, bool> _isNullable = {};
  final Map<String, bool> _typeChecks = {};

  /// Gets the cached display string for a type with nullability.
  ///
  /// This is equivalent to calling `type.getDisplayString()`
  /// but the result is cached for repeated access.
  ///
  /// Example:
  /// ```dart
  /// final typeName = typeCache.getDisplayString(type);
  /// // Returns: "String?" for nullable String
  /// // Returns: "String" for non-nullable String
  /// ```
  String getDisplayString(DartType type) {
    return _displayStrings.putIfAbsent(type, () => type.getDisplayString());
  }

  /// Gets the cached display string for a type element (without nullability).
  ///
  /// This gets the base type name from the type's element, which doesn't
  /// include nullability information. Useful when you want to check the
  /// base type regardless of nullability.
  ///
  /// Example:
  /// ```dart
  /// final baseTypeName = typeCache.getDisplayStringWithoutNullability(type);
  /// // Returns: "String" for both "String?" and "String"
  /// // Returns: "List" for both "List<int>?" and "List<int>"
  /// ```
  String getDisplayStringWithoutNullability(DartType type) {
    return _displayStringsWithoutNullability.putIfAbsent(
      type,
      () => type.element?.displayName ?? type.getDisplayString(),
    );
  }

  /// Checks if a type is nullable (cached).
  ///
  /// Returns `true` if the type has a nullable suffix (`?`).
  ///
  /// Example:
  /// ```dart
  /// if (typeCache.isNullable(type)) {
  ///   // Handle nullable type
  /// }
  /// ```
  bool isNullable(DartType type) {
    return _isNullable.putIfAbsent(
      type,
      () => type.nullabilitySuffix == NullabilitySuffix.question,
    );
  }

  /// Checks if a type's display string contains the given substring (cached).
  ///
  /// This is useful for checking if a type matches a pattern without
  /// repeatedly calling `getDisplayString()`.
  ///
  /// Example:
  /// ```dart
  /// if (typeCache.typeContains(type, 'Widget')) {
  ///   // Type contains "Widget" in its name
  /// }
  /// ```
  bool typeContains(DartType type, String substring) {
    final key = '${type.hashCode}:contains:$substring';
    return _typeChecks.putIfAbsent(
      key,
      () => getDisplayString(type).contains(substring),
    );
  }

  /// Checks if a type's display string matches exactly (cached).
  ///
  /// This is more efficient than repeatedly calling `getDisplayString()`
  /// and comparing the result.
  ///
  /// Example:
  /// ```dart
  /// if (typeCache.typeEquals(type, 'Widget')) {
  ///   // Type is exactly "Widget"
  /// }
  /// ```
  bool typeEquals(DartType type, String typeName) {
    final key = '${type.hashCode}:equals:$typeName';
    return _typeChecks.putIfAbsent(
      key,
      () => getDisplayString(type) == typeName,
    );
  }

  /// Checks if a type's display string starts with the given prefix (cached).
  ///
  /// Useful for checking type families like "List<...>", "Map<...>", etc.
  ///
  /// Example:
  /// ```dart
  /// if (typeCache.typeStartsWith(type, 'List<')) {
  ///   // Type is some kind of List
  /// }
  /// ```
  bool typeStartsWith(DartType type, String prefix) {
    final key = '${type.hashCode}:startsWith:$prefix';
    return _typeChecks.putIfAbsent(
      key,
      () => getDisplayString(type).startsWith(prefix),
    );
  }

  /// Checks if a type's display string ends with the given suffix (cached).
  ///
  /// Useful for checking patterns like "...Exception", "...Error", etc.
  ///
  /// Example:
  /// ```dart
  /// if (typeCache.typeEndsWith(type, 'Exception')) {
  ///   // Type name ends with "Exception"
  /// }
  /// ```
  bool typeEndsWith(DartType type, String suffix) {
    final key = '${type.hashCode}:endsWith:$suffix';
    return _typeChecks.putIfAbsent(
      key,
      () => getDisplayString(type).endsWith(suffix),
    );
  }

  /// Clears all cached data.
  ///
  /// Call this when you're done analyzing a file to free memory.
  /// In most cases, you don't need to call this manually since you
  /// should create a new TypeCache instance for each file.
  void clear() {
    _displayStrings.clear();
    _displayStringsWithoutNullability.clear();
    _isNullable.clear();
    _typeChecks.clear();
  }

  /// Gets statistics about cache usage.
  ///
  /// Useful for performance analysis and debugging.
  ///
  /// Returns a map with:
  /// - `displayStrings`: Number of cached display strings
  /// - `nullabilityChecks`: Number of cached nullability checks
  /// - `typeChecks`: Number of cached type pattern checks
  /// - `totalEntries`: Total number of cached entries
  Map<String, int> get stats => {
    'displayStrings': _displayStrings.length,
    'displayStringsWithoutNullability':
        _displayStringsWithoutNullability.length,
    'nullabilityChecks': _isNullable.length,
    'typeChecks': _typeChecks.length,
    'totalEntries':
        _displayStrings.length +
        _displayStringsWithoutNullability.length +
        _isNullable.length +
        _typeChecks.length,
  };
}
