class Test {
  // Empty method
  // expect_lint: no_empty_block
  void emptyMethod() {}

  // Empty if block
  void testIf(bool condition) {
    // expect_lint: no_empty_block
    if (condition) {}
  }

  // Empty else block
  void testElse(bool condition) {
    if (condition) {
      print('true');
      // expect_lint: no_empty_block
    } else {}
  }

  // Empty for loop
  void testForLoop() {
    // expect_lint: no_empty_block
    for (var i = 0; i < 10; i++) {}
  }

  // Empty while loop
  void testWhile(bool condition) {
    // expect_lint: no_empty_block
    while (condition) {}
  }

  // Empty do-while loop
  void testDoWhile(bool condition) {
    // expect_lint: no_empty_block
    do {} while (condition);
  }

  // Empty forEach
  void testForEach() {
    // expect_lint: no_empty_block
    [1, 2, 3, 4].forEach((val) {});
  }

  // Empty switch case
  void testSwitch(int value) {
    switch (value) {
      case 1:
        // expect_lint: no_empty_block
        {}
        break;

      case 2:
        print('two');
        break;
    }
  }

  // Empty try block
  void testTry() {
    // expect_lint: no_empty_block
    try {} catch (e) {
      print(e);
    }
  }

  // Empty finally block
  void testFinally() {
    try {
      print('try');
      // expect_lint: no_empty_block
    } finally {}
  }

  // Nested empty blocks
  void testNested(bool condition) {
    if (condition) {
      // expect_lint: no_empty_block
      if (condition) {}
    }
  }

  // Empty constructor
  // expect_lint: no_empty_block
  Test() {}

  // Empty named constructor
  // expect_lint: no_empty_block
  Test.named() {}

  // Empty getter with block
  // expect_lint: no_empty_block
  int get value {} // ignore: body_might_complete_normally

  // Empty setter
  // expect_lint: no_empty_block
  set value(int v) {}
}

// Empty top-level function
// expect_lint: no_empty_block
void emptyFunction() {}

// Empty class with empty constructor
class EmptyClass {
  // expect_lint: no_empty_block
  EmptyClass() {}
}

// Empty static method
class StaticTest {
  // expect_lint: no_empty_block
  static void emptyStatic() {}
}

// Empty async function
// expect_lint: no_empty_block
Future<void> emptyAsync() async {}

// Empty callback
void callbackTest() {
  void Function() callback;
  // expect_lint: no_empty_block
  callback = () {};
}

// Empty map function
void mapTest() {
  // expect_lint: no_empty_block
  [1, 2, 3].map((e) {});
}

// Empty then callback
void futureTest() {
  // expect_lint: no_empty_block
  Future.value(1).then((value) {});
}
