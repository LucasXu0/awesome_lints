// Test cases that should trigger the avoid-assigning-to-static-field lint

class MyClass {
  static int value = 1;
  static String name = 'initial';

  void instanceMethod() {
    // expect_lint: avoid_assigning_to_static_field
    value = 2;

    // expect_lint: avoid_assigning_to_static_field
    name = 'changed';

    // expect_lint: avoid_assigning_to_static_field
    value++;

    // expect_lint: avoid_assigning_to_static_field
    ++value;
  }

  void anotherMethod() {
    // expect_lint: avoid_assigning_to_static_field
    MyClass.value = 5;
  }
}

class OtherClass {
  void work() {
    // expect_lint: avoid_assigning_to_static_field
    MyClass.value = 10;
  }
}
