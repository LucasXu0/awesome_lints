class Test {
  void testIfStatement() {
    bool condition = true;
    String result;

    // If-else with different branches
    if (condition) {
      result = 'true';
    } else {
      result = 'false';
    }

    // If-else with different statements
    if (condition) {
      print('hello');
      result = 'value1';
    } else {
      print('goodbye');
      result = 'value2';
    }

    // If without else
    if (condition) {
      result = 'value';
    }

    // If-else-if chain (not checked)
    if (condition) {
      result = 'first';
    } else if (!condition) {
      result = 'second';
    } else {
      result = 'third';
    }

    // Different method calls
    if (condition) {
      print('message1');
    } else {
      print('message2');
    }
  }

  String testReturnStatements(bool condition) {
    // Different return values
    if (condition) {
      return 'true';
    } else {
      return 'false';
    }
  }

  void testConditionalExpression() {
    bool condition = true;

    // Ternary with different values
    final result = condition ? 'true' : 'false';

    // Ternary with different numbers
    final number = condition ? 42 : 0;

    // Ternary with different variable references
    String value1 = 'test1';
    String value2 = 'test2';
    final result2 = condition ? value1 : value2;

    // Ternary with different method calls
    final result3 = condition ? getValue1() : getValue2();

    // Ternary with different expressions
    int x = 5;
    final result4 = condition ? x + 10 : x + 20;
  }

  String getValue1() => 'value1';

  String getValue2() => 'value2';

  void testNestedConditions() {
    bool condition1 = true;
    bool condition2 = false;

    // Nested if with different branches
    if (condition1) {
      if (condition2) {
        print('nested1');
      }
    } else {
      if (condition2) {
        print('nested2');
      }
    }
  }

  void testComplexStatements() {
    bool condition = true;
    final list = <int>[1, 2, 3];

    // If-else with different complex statements
    if (condition) {
      list.add(5);
      list.removeAt(0);
    } else {
      list.add(10);
      list.removeAt(1);
    }
  }
}
