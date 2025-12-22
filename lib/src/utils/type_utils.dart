import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';

/// Utility class for type checking and analysis.
///
/// Provides helpers for common type-related operations in lint rules.
class TypeUtils {
  TypeUtils._();

  /// Common Flutter widget types to check for.
  static const flutterWidgetTypes = {
    'Widget',
    'StatelessWidget',
    'StatefulWidget',
    'InheritedWidget',
    'RenderObjectWidget',
  };

  /// Common collection types.
  static const collectionTypes = {'List', 'Set', 'Map', 'Iterable', 'Queue'};

  /// Checks if a type is a Flutter Widget or subclass of Widget.
  ///
  /// Example:
  /// ```dart
  /// if (TypeUtils.isWidget(type)) {
  ///   // Type is a Widget
  /// }
  /// ```
  static bool isWidget(DartType? type) {
    if (type == null || type is! InterfaceType) return false;
    return _extendsClass(type.element, 'Widget');
  }

  /// Checks if a type is a StatefulWidget.
  static bool isStatefulWidget(DartType? type) {
    if (type == null || type is! InterfaceType) return false;
    return _extendsClass(type.element, 'StatefulWidget');
  }

  /// Checks if a type is a StatelessWidget.
  static bool isStatelessWidget(DartType? type) {
    if (type == null || type is! InterfaceType) return false;
    return _extendsClass(type.element, 'StatelessWidget');
  }

  /// Checks if a type extends or implements a specific class by name.
  ///
  /// Traverses the entire class hierarchy including superclasses,
  /// mixins, and interfaces.
  ///
  /// Example:
  /// ```dart
  /// if (TypeUtils.extendsClass(type, 'State')) {
  ///   // Type extends State
  /// }
  /// ```
  static bool extendsClass(DartType? type, String className) {
    if (type == null || type is! InterfaceType) return false;
    return _extendsClass(type.element, className);
  }

  /// Checks if a class element extends or implements a specific class by name.
  static bool _extendsClass(InterfaceElement element, String className) {
    if (element.name == className) return true;

    // Check superclass
    final supertype = element.supertype;
    if (supertype != null && _extendsClass(supertype.element, className)) {
      return true;
    }

    // Check mixins
    for (final mixin in element.mixins) {
      if (_extendsClass(mixin.element, className)) {
        return true;
      }
    }

    // Check interfaces
    for (final interface in element.interfaces) {
      if (_extendsClass(interface.element, className)) {
        return true;
      }
    }

    return false;
  }

  /// Gets the element type from a collection type (`List<T>`, `Set<T>`, etc.).
  ///
  /// Returns null if the type is not a collection or has no type arguments.
  ///
  /// Example:
  /// ```dart
  /// final elementType = TypeUtils.getCollectionElementType(listType);
  /// // For List<int>, returns int
  /// ```
  static DartType? getCollectionElementType(DartType? type) {
    if (type is! InterfaceType) return null;
    if (type.typeArguments.isEmpty) return null;
    return type.typeArguments.first;
  }

  /// Checks if two types are exactly equal (not subtypes).
  ///
  /// Uses display string comparison to ensure exact matches.
  ///
  /// Example:
  /// ```dart
  /// if (TypeUtils.areExactlyEqual(type1, type2)) {
  ///   // Types are identical
  /// }
  /// ```
  static bool areExactlyEqual(DartType? type1, DartType? type2) {
    if (type1 == null || type2 == null) return false;
    return type1.getDisplayString() == type2.getDisplayString();
  }

  /// Checks if a type is nullable (has ? suffix).
  ///
  /// Example:
  /// ```dart
  /// if (TypeUtils.isNullable(type)) {
  ///   // Type is nullable
  /// }
  /// ```
  static bool isNullable(DartType? type) {
    return type?.nullabilitySuffix == NullabilitySuffix.question;
  }

  /// Checks if a type is dynamic.
  static bool isDynamic(DartType? type) {
    return type is DynamicType;
  }

  /// Checks if a type is void.
  static bool isVoid(DartType? type) {
    return type is VoidType;
  }

  /// Checks if a type is a Future.
  static bool isFuture(DartType? type) {
    if (type is! InterfaceType) return false;
    return type.element.name == 'Future';
  }

  /// Checks if a type is a Stream.
  static bool isStream(DartType? type) {
    if (type is! InterfaceType) return false;
    return type.element.name == 'Stream';
  }

  /// Checks if a type is a function type.
  static bool isFunction(DartType? type) {
    return type is FunctionType;
  }

  /// Checks if a type is a collection (List, Set, Map, Iterable, etc.).
  static bool isCollection(DartType? type) {
    if (type is! InterfaceType) return false;
    return collectionTypes.contains(type.element.name);
  }

  /// Gets the return type from a `Future<T>`.
  ///
  /// Returns null if the type is not a Future or has no type arguments.
  ///
  /// Example:
  /// ```dart
  /// final returnType = TypeUtils.getFutureReturnType(futureType);
  /// // For Future<String>, returns String
  /// ```
  static DartType? getFutureReturnType(DartType? type) {
    if (type is! InterfaceType) return null;
    if (type.element.name != 'Future') return null;
    if (type.typeArguments.isEmpty) return null;
    return type.typeArguments.first;
  }

  /// Gets the element type from a `Stream<T>`.
  ///
  /// Returns null if the type is not a Stream or has no type arguments.
  static DartType? getStreamElementType(DartType? type) {
    if (type is! InterfaceType) return null;
    if (type.element.name != 'Stream') return null;
    if (type.typeArguments.isEmpty) return null;
    return type.typeArguments.first;
  }

  /// Checks if a type implements a specific interface by name.
  ///
  /// Example:
  /// ```dart
  /// if (TypeUtils.implementsInterface(type, 'Comparable')) {
  ///   // Type implements Comparable
  /// }
  /// ```
  static bool implementsInterface(DartType? type, String interfaceName) {
    if (type is! InterfaceType) return false;

    for (final interface in type.element.interfaces) {
      if (interface.element.name == interfaceName) return true;
      // Recursively check super-interfaces
      if (implementsInterface(interface, interfaceName)) return true;
    }

    // Also check superclass
    final supertype = type.element.supertype;
    if (supertype != null && implementsInterface(supertype, interfaceName)) {
      return true;
    }

    return false;
  }
}
