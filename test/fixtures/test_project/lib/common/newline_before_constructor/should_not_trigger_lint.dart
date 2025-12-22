// First constructor - no lint
class FirstConstructor {
  FirstConstructor();
}

// Proper spacing between constructors
class ProperSpacingBetweenConstructors {
  ProperSpacingBetweenConstructors();

  ProperSpacingBetweenConstructors.named();

  ProperSpacingBetweenConstructors.other();
}

// Proper spacing with field before
class FieldThenConstructor {
  int value = 0;

  FieldThenConstructor();
}

// Multiple fields with proper spacing
class MultipleFieldsProperSpacing {
  String name = 'test';
  int age = 25;

  MultipleFieldsProperSpacing();
}

// Factory constructor with proper spacing
class FactoryConstructorProper {
  FactoryConstructorProper();

  factory FactoryConstructorProper.create() => FactoryConstructorProper();
}

// Const constructors with proper spacing
class ConstConstructorsProper {
  const ConstConstructorsProper();

  const ConstConstructorsProper.named();
}

// Private constructors with proper spacing
class PrivateConstructorsProper {
  PrivateConstructorsProper._();

  PrivateConstructorsProper._named();
}

// Redirecting constructors with proper spacing
class RedirectingConstructorsProper {
  RedirectingConstructorsProper();

  RedirectingConstructorsProper.redirect() : this();
}

// Constructor with initializer list
class InitializerListProper {
  final int x;

  InitializerListProper() : x = 0;

  InitializerListProper.withValue(this.x);
}

// Generative constructors with proper spacing
class GenerativeConstructorsProper {
  final String value;

  GenerativeConstructorsProper(this.value);

  GenerativeConstructorsProper.empty() : value = '';
}

// Proper spacing with method before constructor
class MethodThenConstructor {
  void method() {}

  MethodThenConstructor();
}

// All member types with proper spacing
class AllMemberTypesProper {
  int field = 0;

  AllMemberTypesProper();

  AllMemberTypesProper.named();

  factory AllMemberTypesProper.create() => AllMemberTypesProper();

  void method() {}
}

// Only a single constructor
class SingleConstructorOnly {
  SingleConstructorOnly();
}

// Empty class (no constructor)
class EmptyClass {}

// Constructor after getter with proper spacing
class GetterThenConstructor {
  int get value => 42;

  GetterThenConstructor();
}

// Complex constructors with proper spacing
class ComplexConstructors {
  final int a;
  final String b;

  ComplexConstructors(this.a, this.b);

  ComplexConstructors.defaultValues() : a = 0, b = '';

  factory ComplexConstructors.fromJson(Map<String, dynamic> json) {
    return ComplexConstructors(json['a'] as int, json['b'] as String);
  }
}
