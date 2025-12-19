// ignore_for_file: unused_element

class MultipleConstructorsNoSpacing {
  MultipleConstructorsNoSpacing();
}

class ConstructorAfterField {
  int value = 0;
}

class ConstructorAfterMultipleFields {
  String name = 'test';
  int age = 25;
  ConstructorAfterMultipleFields();
}

class FactoryAfterConstructor {
  FactoryAfterConstructor();
  factory FactoryAfterConstructor.create() => FactoryAfterConstructor();
}

class NamedConstructorsNoSpacing {
  NamedConstructorsNoSpacing.first();
  NamedConstructorsNoSpacing.second();
  NamedConstructorsNoSpacing.third();
}

class ConstConstructor {
  const ConstConstructor();
  const ConstConstructor.named();
}

class PrivateConstructors {
  PrivateConstructors._();
  PrivateConstructors._named();
}

class ConstructorAfterGetter {
  int get value => 42;
  ConstructorAfterGetter();
}

class RedirectingConstructors {
  RedirectingConstructors();
  RedirectingConstructors.redirect() : this();
}

class ConstructorWithInitializer {
  final int x;
  ConstructorWithInitializer() : x = 0;
  ConstructorWithInitializer.withValue(this.x);
}

class GenerativeConstructors {
  final String value;

  GenerativeConstructors(this.value);
  GenerativeConstructors.empty() : value = 'A';
}

class ConstructorAfterMethod {
  void method() {}
  ConstructorAfterMethod();
}

class MixedMembersAndConstructors {
  int field = 0;
  MixedMembersAndConstructors();
  MixedMembersAndConstructors.named();
}
