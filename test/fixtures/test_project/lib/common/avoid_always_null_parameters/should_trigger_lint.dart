// Test cases that should trigger the avoid-always-null-parameters lint

class MyClass {
  void work() {
    _helper(null);
    _helper(null);
  }

  void otherWork() {
    _helper(null);
  }

  // expect_lint: avoid_always_null_parameters
  void _helper(String? value) {
    print(value);
  }
}

class AnotherClass {
  void test() {
    _process(null, null);
    _process(null, null);
  }

  // Both parameters always receive null
  // expect_lint: avoid_always_null_parameters
  void _process(String? first, int? second) {
    print('$first $second');
  }
}
