// ignore_for_file: dead_code, unused_local_variable

class Test {
  void testIfStatement() {
    bool condition = true;
    String result;

    // Basic if-else with identical branches
    // expect_lint: no_equal_then_else
    if (condition) {
      result = 'same';
    } else {
      result = 'same';
    }

    // If-else with identical block statements
    // expect_lint: no_equal_then_else
    if (condition) {
      print('hello');
      result = 'value';
    } else {
      print('hello');
      result = 'value';
    }

    // If-else with identical single statement
    int value = 0;
    // expect_lint: no_equal_then_else
    if (condition) {
      value = 10;
    } else {
      value = 10;
    }

    // If-else with identical method calls
    // expect_lint: no_equal_then_else
    if (condition) {
      print('message');
    } else {
      print('message');
    }

    // If-else with identical return statements
    final result2 = _testReturnStatements(condition);
  }

  String _testReturnStatements(bool condition) {
    // expect_lint: no_equal_then_else
    if (condition) {
      return 'same';
    } else {
      return 'same';
    }
  }

  void testConditionalExpression() {
    bool condition = true;

    // Basic ternary with identical values
    // expect_lint: no_equal_then_else
    final result = condition ? 'same' : 'same';

    // Ternary with identical numbers
    // expect_lint: no_equal_then_else
    final number = condition ? 42 : 42;

    // Ternary with identical variable references
    String value = 'test';
    // expect_lint: no_equal_then_else
    final result2 = condition ? value : value;

    // Ternary with identical method calls
    // expect_lint: no_equal_then_else
    final result3 = condition ? getValue() : getValue();

    // Ternary with identical expressions
    int x = 5;
    // expect_lint: no_equal_then_else
    final result4 = condition ? x + 10 : x + 10;
  }

  String getValue() => 'value';

  void testNestedConditions() {
    bool condition1 = true;
    bool condition2 = false;

    // Nested if with identical branches in outer if
    // expect_lint: no_equal_then_else
    if (condition1) {
      if (condition2) {
        print('nested');
      }
    } else {
      if (condition2) {
        print('nested');
      }
    }
  }

  void testComplexStatements() {
    bool condition = true;
    final list = <int>[1, 2, 3];

    // If-else with identical complex statements
    // expect_lint: no_equal_then_else
    if (condition) {
      list.add(5);
      list.removeAt(0);
    } else {
      list.add(5);
      list.removeAt(0);
    }
  }
}
