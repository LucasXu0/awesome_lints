// Test cases that should trigger the avoid-accessing-other-classes-private-members lint

class SomeClass {
  final String _privateField = 'private';
  String _privateMethod() => 'private method';

  String get _privateGetter => 'private getter';
}

class OtherClass {
  void test(SomeClass other) {
    // expect_lint: avoid_accessing_other_classes_private_members
    print(other._privateField);

    // expect_lint: avoid_accessing_other_classes_private_members
    print(other._privateMethod());

    // expect_lint: avoid_accessing_other_classes_private_members
    print(other._privateGetter);
  }
}

class AnotherClass {
  void work() {
    final some = SomeClass();
    // expect_lint: avoid_accessing_other_classes_private_members
    print(some._privateField);
  }
}
