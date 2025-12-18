// ignore_for_file: dead_code, unused_local_variable

class User {
  final String firstName;
  final String lastName;
  final String email;
  final int age;

  User(this.firstName, this.lastName, this.email, this.age);

  User.named({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.age,
  });
}

class Test {
  // Different variables in constructor
  void testConstructor() {
    var firstName = 'John';
    var lastName = 'Doe';
    var email = 'john@example.com';

    var user1 = User(firstName, lastName, email, 30);
    var user2 = User('Jane', 'Smith', 'jane@example.com', 25);
  }

  // Different variables in named constructor
  void testNamedConstructor() {
    var firstName = 'John';
    var lastName = 'Doe';

    var user = User.named(
      firstName: firstName,
      lastName: lastName,
      email: 'john@example.com',
      age: 30,
    );
  }

  // Different variables in function call
  void testFunctionCall() {
    var firstName = 'John';
    var lastName = 'Doe';

    var fullName = getFullName(firstName, lastName);
    var result = calculate(5, 10, 15);
  }

  // Different property access
  void testPropertyAccess() {
    var user = User('John', 'Doe', 'john@example.com', 30);

    compare(user.firstName, user.lastName);
    processData(user.firstName, user.email, user.age);
  }

  // Different method calls
  void testMethodCall() {
    compare(getValue(), getOtherValue());
    processThree(compute(), calculate2(), 10);
  }

  // Different values in list methods
  void testListMethods() {
    var list = <int>[];
    list.fillRange(0, 10, 5);

    var items = <String>[];
    combine('hello', 'world');
  }

  // Different keys in map methods
  void testMapMethods() {
    var map = <String, String>{};
    map.putIfAbsent('key1', () => 'value1');
  }

  // Different values in math operations
  void testMathOperations() {
    var x = 10;
    var y = 20;

    var result = max(x, y);
    var min = minimum(x, y, 30);
  }

  // Different complex expressions
  void testComplexExpressions() {
    var list1 = [1, 2, 3];
    var list2 = [4, 5, 6];

    compare(list1.first, list2.first);
    var result = calculate(list1.length, list2.length, 5);
  }

  // Different in nested calls
  void testNestedCalls() {
    var value1 = 'test';
    var value2 = 'other';

    outer(value1, value2, inner(1, 2));
  }

  // Different getter calls
  void testGetters() {
    var obj1 = MyClass();
    var obj2 = MyClass();

    compare(obj1.value, obj2.value);
  }

  // Single argument (no comparison needed)
  void testSingleArgument() {
    print('hello');
    var user = SingleArgConstructor('John');
  }

  // Identical literal numbers (acceptable)
  void testLiterals() {
    var result1 = calculate(1, 2, 3);
    var result2 = max(5, 10);
    compare('hello', 'world');
  }

  String getValue() => 'value';
  
String getOtherValue() => 'other';
  
int compute() => 42;
  
int calculate2() => 100;
}

String getFullName(String first, String last) => '$first $last';

void compare(dynamic a, dynamic b) {}

void processData(String a, String b, int c) {}

void processThree(int a, int b, int c) {}

void combine(String a, String b) {}

int max(int a, int b) => a > b ? a : b;

int minimum(int a, int b, int c) => a;

int calculate(int a, int b, int c) => a + b + c;

void outer(String a, String b, int c) {}

int inner(int a, int b) => a + b;

class MyClass {
  int get value => 42;
}

class SingleArgConstructor {
  final String value;
  
SingleArgConstructor(this.value);
}

// Top-level function with different arguments
void topLevel() {
  var x = 10;
  var y = 20;
  compare(x, y);
}

// In callback with different values
void testCallback() {
  var items = [1, 2, 3];
  items.fold(0, (prev, element) => prev + element);
}

// Chain method calls with different arguments
void testChaining() {
  var str = 'hello';
  str.replaceAll('l', 'r');
}

// Zero arguments
void testNoArguments() {
  noArgs();
}

void noArgs() {}

// Repeated literal values (allowed since they're literals)
void testRepeatedLiterals() {
  var point = Point(0, 0);
  var rect = Rectangle(0, 0, 100, 100);
}

class Point {
  final int x;
  final int y;
  
Point(this.x, this.y);
}

class Rectangle {
  final int x;
  final int y;
  final int width;
  final int height;
  
Rectangle(this.x, this.y, this.width, this.height);
}

// Different variable names with same value (should not trigger)
void testDifferentVariables() {
  var value1 = 'test';
  var value2 = 'test';
  // These are different variables, even though they have the same value
  // The source code is different: value1 vs value2
  compare(value1, value2);
}
