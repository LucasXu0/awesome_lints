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
  // Duplicate variable in constructor
  void testConstructor() {
    var firstName = 'John';
    var lastName = 'Doe';

    // expect_lint: no_equal_arguments
    var user1 = User(firstName, firstName, 'john@example.com', 30);

    // expect_lint: no_equal_arguments
    var user2 = User('Jane', 'Jane', 'jane@example.com', 25);
  }

  // Duplicate variable in named constructor
  void testNamedConstructor() {
    var firstName = 'John';

    // expect_lint: no_equal_arguments
    var user = User.named(
      firstName: firstName,
      lastName: firstName,
      email: 'john@example.com',
      age: 30,
    );
  }

  // Duplicate variable in function call
  void testFunctionCall() {
    var firstName = 'John';

    // expect_lint: no_equal_arguments
    var fullName = getFullName(firstName, firstName);

    // expect_lint: no_equal_arguments
    var result = calculate(5, 5, 10);
  }

  // Duplicate property access
  void testPropertyAccess() {
    var user = User('John', 'Doe', 'john@example.com', 30);

    // expect_lint: no_equal_arguments
    compare(user.firstName, user.firstName);

    // expect_lint: no_equal_arguments
    processData(user.email, user.email, user.age);
  }

  // Duplicate method call
  void testMethodCall() {
    // expect_lint: no_equal_arguments
    compare(getValue(), getValue());

    // expect_lint: no_equal_arguments
    processThree(compute(), compute(), 10);
  }

  // Duplicate in list methods
  void testListMethods() {
    var list = <int>[];
    var value = 5;

    // expect_lint: no_equal_arguments
    list.fillRange(0, 10, value);

    var items = <String>[];
    var item = 'hello';
    // expect_lint: no_equal_arguments
    combine(item, item);
  }

  // Duplicate in map methods
  void testMapMethods() {
    var map = <String, String>{};
    var key = 'key1';

    // expect_lint: no_equal_arguments
    map.putIfAbsent(key, () => key);
  }

  // Duplicate in math operations
  void testMathOperations() {
    var x = 10;

    // expect_lint: no_equal_arguments
    var result = max(x, x);

    // expect_lint: no_equal_arguments
    var min = minimum(x, x, x);
  }

  // Duplicate complex expressions
  void testComplexExpressions() {
    var list = [1, 2, 3];

    // expect_lint: no_equal_arguments
    compare(list.first, list.first);

    // expect_lint: no_equal_arguments
    var result = calculate(list.length, list.length, 5);
  }

  // Duplicate in nested calls
  void testNestedCalls() {
    var value = 'test';

    // expect_lint: no_equal_arguments
    outer(value, value, inner(1, 2));
  }

  // Duplicate getter calls
  void testGetters() {
    var obj = MyClass();

    // expect_lint: no_equal_arguments
    compare(obj.value, obj.value);
  }

  String getValue() => 'value';
  
int compute() => 42;
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

// Top-level function with duplicate arguments
void topLevel() {
  var x = 10;
  // expect_lint: no_equal_arguments
  compare(x, x);
}

// In callback
void testCallback() {
  var items = [1, 2, 3];
  var value = 5;

  // expect_lint: no_equal_arguments
  items.fold(value, (prev, element) => prev + value);
}

// Chain method calls with duplicates
void testChaining() {
  var str = 'hello';

  // expect_lint: no_equal_arguments
  str.replaceAll(str, str);
}
