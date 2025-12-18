// ignore_for_file: unused_element

// First method in class - no lint
class FirstMethodNoLint {
  void firstMethod() {}
}

// Proper spacing between methods
class ProperSpacing {
  void firstMethod() {}

  void secondMethod() {}

  void thirdMethod() {}
}

// Proper spacing with fields
class ProperSpacingWithFields {
  int field = 0;

  void method() {}
}

// Multiple fields then method with spacing
class MultipleFieldsThenMethod {
  String name = 'test';
  int age = 25;

  void printInfo() {
    print('$name, $age');
  }
}

// Constructor as first member
class ConstructorFirst {
  ConstructorFirst();

  void method() {}
}

// Proper spacing with getters and setters
class GettersSettersAndMethods {
  String _value = '';

  String get value => _value;

  set value(String v) => _value = v;

  void useValue() {
    print(value);
  }
}

// Single method only
class SingleMethod {
  void onlyMethod() {}
}

// Static and instance with proper spacing
class StaticAndInstanceProper {
  static void staticMethod() {}

  void instanceMethod() {}
}

// Async methods with proper spacing
class AsyncMethodsProper {
  Future<void> first() async {}

  Future<void> second() async {}

  Future<void> third() async {}
}

// Generic methods with proper spacing
class GenericMethodsProper {
  T identity<T>(T value) => value;

  List<T> toList<T>(T value) => [value];
}

// Mixed member types with proper spacing
class AllMemberTypes {
  // Field
  int field = 0;

  // Constructor
  AllMemberTypes();

  // Getter
  int get doubled => field * 2;

  // Setter
  set doubled(int value) => field = value ~/ 2;

  // Static method
  static void staticMethod() {}

  // Instance method
  void instanceMethod() {}

  // Private method
  void _privateMethod() {}
}

// Expression body methods
class ExpressionBodyMethods {
  int getValue() => 42;

  String getName() => 'test';
}
