import 'package:analyzer/dart/element/type.dart';

/// Utility class for checking type compatibility in collection operations.
///
/// This class provides methods to determine if an argument type is compatible
/// with an expected type, which is useful for detecting type mismatches in
/// collection operations like contains(), remove(), indexOf(), etc.
class TypeCompatibilityChecker {
  const TypeCompatibilityChecker();

  /// Checks if [argumentType] is compatible with [expectedType].
  ///
  /// Returns `true` if:
  /// - Either type is dynamic
  /// - Expected type is Object
  /// - Argument is null and expected type is nullable
  /// - Types are exactly equal
  /// - Types have compatible type elements
  /// - Types follow num/int/double hierarchy rules
  ///
  /// Otherwise returns `false`.
  bool isCompatible(DartType argumentType, DartType expectedType) {
    // Check if types have dynamic element (dynamic type)
    if (argumentType.element?.name == 'dynamic' ||
        expectedType.element?.name == 'dynamic') {
      return true;
    }

    // Object is compatible with everything
    if (expectedType.isDartCoreObject) {
      return true;
    }

    // Null type is compatible with nullable types
    if (argumentType.element?.name == 'Null') {
      return true;
    }

    // Check if argument type is exactly the expected type
    if (argumentType == expectedType) {
      return true;
    }

    // Check subtype relationship for interface types
    if (argumentType is InterfaceType && expectedType is InterfaceType) {
      if (argumentType.element == expectedType.element) {
        return true;
      }
    }

    // Simple name-based check for compatibility
    // This is a simplified approach that may have some false negatives
    // but avoids the complexity of full type hierarchy analysis
    final argName = argumentType.element?.name;
    final expName = expectedType.element?.name;

    if (argName == expName) {
      return true;
    }

    // Check for num/int/double compatibility
    if (expName == 'num' && (argName == 'int' || argName == 'double')) {
      return true;
    }
    if (expName == 'int' && argName == 'int') {
      return true;
    }
    if (expName == 'double' && argName == 'double') {
      return true;
    }

    // If types are completely different, they're incompatible
    return false;
  }

  /// Checks if [indexType] is compatible with [listType].
  ///
  /// For lists, the index must be an int.
  /// Returns `true` if compatible, `false` otherwise.
  bool isValidListIndex(DartType indexType) {
    return indexType.isDartCoreInt;
  }

  /// Checks if [keyType] is compatible with a map's key type.
  ///
  /// Extracts the key type from [mapType] and checks compatibility with [keyType].
  bool isValidMapKey(InterfaceType mapType, DartType keyType) {
    final typeArgs = mapType.typeArguments;
    if (typeArgs.isEmpty) return true; // Dynamic map

    final expectedKeyType = typeArgs[0];
    return isCompatible(keyType, expectedKeyType);
  }

  /// Checks if [valueType] is compatible with a map's value type.
  ///
  /// Extracts the value type from [mapType] and checks compatibility with [valueType].
  bool isValidMapValue(InterfaceType mapType, DartType valueType) {
    final typeArgs = mapType.typeArguments;
    if (typeArgs.length < 2) return true; // Dynamic map

    final expectedValueType = typeArgs[1];
    return isCompatible(valueType, expectedValueType);
  }

  /// Checks if [elementType] is compatible with a list or set's element type.
  ///
  /// Extracts the element type from [collectionType] and checks compatibility.
  bool isValidCollectionElement(
    InterfaceType collectionType,
    DartType elementType,
  ) {
    final typeArgs = collectionType.typeArguments;
    if (typeArgs.isEmpty) return true; // Dynamic collection

    final expectedElementType = typeArgs.first;
    return isCompatible(elementType, expectedElementType);
  }
}
