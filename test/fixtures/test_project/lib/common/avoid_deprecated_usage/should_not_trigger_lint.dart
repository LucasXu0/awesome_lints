class SomeOtherClass {}

class Example {
  void newMethod() {
    print('use this instead');
  }
}

void goodExamples() {
  final instance = SomeOtherClass();
  print(instance);

  final example = Example();
  example.newMethod();
}
