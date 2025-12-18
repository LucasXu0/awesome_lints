class SomeClass {}

class AnotherClass {
  final String name;
  AnotherClass(this.name);
}

void badExamples(SomeClass some, AnotherClass another) {
  // expect_lint: avoid_default_tostring
  some.toString();

  // expect_lint: avoid_default_tostring
  print('$some');

  // expect_lint: avoid_default_tostring
  [some].toString();

  // expect_lint: avoid_default_tostring
  another.toString();

  // expect_lint: avoid_default_tostring
  print('Value: $another');
}
