// ignore_for_file: unused_element

class NoSpacingBetweenMethods {
  // expect_lint: newline_before_method
  void firstMethod() {}
  // expect_lint: newline_before_method
  void secondMethod() {}
  // expect_lint: newline_before_method
  void thirdMethod() {}
}

class MixedMembers {
  int field = 0;
  // expect_lint: newline_before_method
  void method() {}
}

class MethodAfterConstructor {
  MethodAfterConstructor();
  // expect_lint: newline_before_method
  void doSomething() {}
}

class MultipleMethodsNoSpacing {
  // expect_lint: newline_before_method
  void a() {}
  // expect_lint: newline_before_method
  void b() {}
  // expect_lint: newline_before_method
  void c() {}
  // expect_lint: newline_before_method
  void d() {}
}

class MethodAfterField {
  String name = 'test';
  // expect_lint: newline_before_method
  void printName() {
    print(name);
  }
}

class MethodAfterGetter {
  String get value => 'value';
  // expect_lint: newline_before_method
  void useValue() {
    print(value);
  }
}

class MethodAfterSetter {
  // expect_lint: newline_before_method
  set value(String v) {}
  // expect_lint: newline_before_method
  void method() {}
}

class StaticAndInstanceMethods {
  // expect_lint: newline_before_method
  static void staticMethod() {}
  // expect_lint: newline_before_method
  void instanceMethod() {}
}

class AsyncMethods {
  Future<void> first() async {}
  // expect_lint: newline_before_method
  Future<void> second() async {}
}

class PrivateAndPublicMethods {
  // expect_lint: newline_before_method
  void publicMethod() {}
  // expect_lint: newline_before_method
  void _privateMethod() {}
}

class GenericMethods {
  // expect_lint: newline_before_method
  T identity<T>(T value) => value;
  // expect_lint: newline_before_method
  List<T> toList<T>(T value) => [value];
}

class MethodAfterMultipleFields {
  int x = 1;
  int y = 2;
  // expect_lint: newline_before_method
  int sum() => x + y;
}
