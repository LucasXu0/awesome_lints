// Test cases that should NOT trigger the avoid-always-null-parameters lint

class MyClass {
  void work() {
    _helper('value');
    _helper(null);
  }

  void _helper(String? value) {
    print(value);
  }
}

class AnotherClass {
  void test() {
    _process('test');
    _process(null);
  }

  void _process(String? value) {
    print(value);
  }
}

// Public functions are not checked
void publicFn(String? value) {
  print(value);
}

void caller() {
  publicFn(null);
  publicFn(null);
}

class WithRequired {
  void test() {
    _process('required');
  }

  void _process(String value) {
    print(value);
  }
}
