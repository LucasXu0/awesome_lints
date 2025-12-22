import 'dart:ui';

class Test {
  // Method with implementation
  void methodWithCode() {
    print('hello');
  }

  // If block with code
  void testIf(bool condition) {
    if (condition) {
      print('true');
    }
  }

  // Else block with code
  void testElse(bool condition) {
    if (condition) {
      print('true');
    } else {
      print('false');
    }
  }

  // For loop with code
  void testForLoop() {
    for (var i = 0; i < 10; i++) {
      print(i);
    }
  }

  // While loop with code
  void testWhile(bool condition) {
    while (condition) {
      print('looping');
      break;
    }
  }

  // Do-while with code
  void testDoWhile(bool condition) {
    do {
      print('once');
    } while (condition);
  }

  // forEach with code
  void testForEach() {
    [1, 2, 3, 4].forEach((val) {
      print(val);
    });
  }

  // Switch case with code
  void testSwitch(int value) {
    switch (value) {
      case 1:
        print('one');
        break;

      case 2:
        print('two');
        break;
    }
  }

  // Try-catch with code
  void testTry() {
    try {
      print('try');
    } catch (e) {
      print(e);
    }
  }

  // Empty catch block (explicitly ignored in rule description)
  void testEmptyCatch() {
    try {
      riskyOperation();
    } catch (e) {
      // Intentionally left empty - errors are expected
    }
  }

  // Finally with code
  void testFinally() {
    try {
      print('try');
    } finally {
      print('cleanup');
    }
  }

  // Constructor with initialization
  Test() {
    print('initializing');
  }

  // Named constructor with code
  Test.named() {
    print('named constructor');
  }

  // Getter with implementation
  int get value {
    return 42;
  }

  // Setter with implementation
  set value(int v) {
    print('setting value: $v');
  }

  // Block with only comment
  void withComment() {
    // This is a comment explaining why it's empty
  }

  void riskyOperation() {
    // do nothing
  }
}

// Function with implementation
void functionWithCode() {
  print('hello');
}

// Class with proper constructor
class ProperClass {
  ProperClass() {
    print('initialized');
  }
}

// Static method with code
class StaticTest {
  static void staticMethod() {
    print('static');
  }
}

// Async function with await
Future<void> asyncFunction() async {
  await Future.delayed(Duration(seconds: 1));
}

// Callback with code
void callbackTest() {
  VoidCallback callback;

  callback = () {
    print('callback');
  };
}

// Map with transformation
void mapTest() {
  [1, 2, 3].map((e) {
    return e * 2;
  });
}

// Then callback with code
void futureTest() {
  Future.value(1).then((value) {
    print(value);
  });
}

// Expression body (not a block)
void expressionBody() => print('expression');

// Arrow function
int add(int a, int b) => a + b;

// One-liner with expression
void oneLiner(bool flag) => flag ? print('yes') : print('no');
