// ignore_for_file: unused_element

class NoSpacingBetweenMethods {
  void firstMethod() {}
  void secondMethod() {}
  void thirdMethod() {}
}

class MixedMembers {
  int field = 0;
  void method() {}
}

class MethodAfterConstructor {
  MethodAfterConstructor();
  void doSomething() {}
}

class MultipleMethodsNoSpacing {
  void a() {}
  void b() {}
  void c() {}
  void d() {}
}

class MethodAfterField {
  String name = 'test';
  void printName() {
    print(name);
  }
}

class MethodAfterGetter {
  String get value => 'value';
  void useValue() {
    print(value);
  }
}

class MethodAfterSetter {
  set value(String v) {}
  void method() {}
}

class StaticAndInstanceMethods {
  static void staticMethod() {}
  void instanceMethod() {}
}

class AsyncMethods {
  Future<void> first() async {}
  Future<void> second() async {}
}

class PrivateAndPublicMethods {
  void publicMethod() {}
  void _privateMethod() {}
}

class GenericMethods {
  T identity<T>(T value) => value;
  List<T> toList<T>(T value) => [value];
}

class MethodAfterMultipleFields {
  int x = 1;
  int y = 2;
  int sum() => x + y;
}
