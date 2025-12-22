class SomeClass {
  @override
  String toString() => 'SomeClass instance';
}

class AnotherClass {
  final String name;

  AnotherClass(this.name);

  @override
  String toString() => 'AnotherClass(name: $name)';
}

void goodExamples(SomeClass some, AnotherClass another) {
  // Classes with custom toString implementations
  some.toString();
  print('$some');

  another.toString();
  print('Value: $another');

  // Primitive types are fine
  final num = 42;
  print('$num');

  final text = 'hello';
  print('$text');
}
