class Test {
  void testList() {
    final list = [1, 2, 3, 4, 5];

    // indexOf with == -1 (should use !contains)
    // expect_lint: prefer_contains
    if (list.indexOf(1) == -1) {
      print('not found');
    }

    // indexOf with != -1 (should use contains)
    // expect_lint: prefer_contains
    if (list.indexOf(2) != -1) {
      print('found');
    }

    // -1 on the left side with ==
    // expect_lint: prefer_contains
    if (-1 == list.indexOf(3)) {
      print('not found');
    }

    // -1 on the left side with !=
    // expect_lint: prefer_contains
    if (-1 != list.indexOf(4)) {
      print('found');
    }

    // In variable assignment
    // expect_lint: prefer_contains
    var notFound = list.indexOf(5) == -1;

    // expect_lint: prefer_contains
    var found = list.indexOf(6) != -1;

    // In return statement
    if (checkNotInList(list, 7)) {
      print('check');
    }

    // In while loop
    // expect_lint: prefer_contains
    while (list.indexOf(8) != -1) {
      break;
    }

    // In ternary expression
    // expect_lint: prefer_contains
    var message = list.indexOf(9) == -1 ? 'not found' : 'found';

    // expect_lint: prefer_contains
    var message2 = list.indexOf(10) != -1 ? 'found' : 'not found';

    // Combined with logical operators
    // expect_lint: prefer_contains
    if (list.indexOf(11) != -1 && list.length > 5) {
      print('found and long');
    }

    // expect_lint: prefer_contains
    if (list.indexOf(12) == -1 || list.isEmpty) {
      print('not found or empty');
    }
  }

  bool checkNotInList(List<int> list, int value) {
    // expect_lint: prefer_contains
    return list.indexOf(value) == -1;
  }

  void testString() {
    final str = 'hello world';

    // String indexOf with == -1
    // expect_lint: prefer_contains
    if (str.indexOf('hello') == -1) {
      print('not found');
    }

    // String indexOf with != -1
    // expect_lint: prefer_contains
    if (str.indexOf('world') != -1) {
      print('found');
    }

    // Pattern with RegExp
    // expect_lint: prefer_contains
    if (str.indexOf(RegExp(r'\d+')) == -1) {
      print('no digits');
    }
  }

  void testNestedCalls() {
    final list = [1, 2, 3];

    // Nested in function call
    // expect_lint: prefer_contains
    print(list.indexOf(1) == -1);

    // expect_lint: prefer_contains
    print(list.indexOf(2) != -1);
  }

  void testComplexExpressions() {
    final list = ['a', 'b', 'c'];

    // With method chain
    // expect_lint: prefer_contains
    if (list.map((e) => e.toUpperCase()).toList().indexOf('A') == -1) {
      print('not found');
    }

    // In assert
    // expect_lint: prefer_contains
    assert(list.indexOf('d') == -1);

    // expect_lint: prefer_contains
    assert(list.indexOf('a') != -1);
  }
}
