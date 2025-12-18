// ignore_for_file: unused_element

class MultipleConstructorsNoSpacing {
  MultipleConstructorsNoSpacing();
  
MultipleConstructorsNoSpacing.named(); // expect_lint: newline_before_constructor
  MultipleConstructorsNoSpacing.other(); // expect_lint: newline_before_constructor
}

class ConstructorAfterField {
  int value = 0;
  
ConstructorAfterField(); // expect_lint: newline_before_constructor
}

class ConstructorAfterMultipleFields {
  String name = 'test';
  int age = 25;
  // expect_lint: newline_before_constructor
  ConstructorAfterMultipleFields();
}

class FactoryAfterConstructor {
  FactoryAfterConstructor();
  // expect_lint: newline_before_constructor
  factory FactoryAfterConstructor.create() => FactoryAfterConstructor();
}

class NamedConstructorsNoSpacing {
  NamedConstructorsNoSpacing.first();
  // expect_lint: newline_before_constructor
  NamedConstructorsNoSpacing.second();
  // expect_lint: newline_before_constructor
  NamedConstructorsNoSpacing.third();
}

class ConstConstructor {
  const ConstConstructor();
  // expect_lint: newline_before_constructor
  const ConstConstructor.named();
}

class PrivateConstructors {
  PrivateConstructors._();
  // expect_lint: newline_before_constructor
  PrivateConstructors._named();
}

class ConstructorAfterGetter {
  int get value => 42;
  // expect_lint: newline_before_constructor
  ConstructorAfterGetter();
}

class RedirectingConstructors {
  RedirectingConstructors();
  // expect_lint: newline_before_constructor
  RedirectingConstructors.redirect() : this();
}

class ConstructorWithInitializer {
  final int x;
  // expect_lint: newline_before_constructor
  ConstructorWithInitializer() : x = 0;
  // expect_lint: newline_before_constructor
  ConstructorWithInitializer.withValue(this.x);
}

class GenerativeConstructors {
  final String value;
  
GenerativeConstructors(this.value);
  // expect_lint: newline_before_constructor
  GenerativeConstructors.empty() : value = '';
}

class ConstructorAfterMethod {
  void method() {}
  // expect_lint: newline_before_constructor
  ConstructorAfterMethod();
}

class MixedMembersAndConstructors {
  int field = 0;
  // expect_lint: newline_before_constructor
  MixedMembersAndConstructors();
  // expect_lint: newline_before_constructor
  MixedMembersAndConstructors.named();
}
