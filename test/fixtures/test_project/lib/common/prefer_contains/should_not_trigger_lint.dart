class Test {
  void testProperContainsUsage() {
    final list = [1, 2, 3, 4, 5];

    // Using contains directly - this is good
    if (list.contains(1)) {
      print('found');
    }

    // Using negated contains - this is good
    if (!list.contains(2)) {
      print('not found');
    }

    // In variable assignment
    var found = list.contains(3);
    var notFound = !list.contains(4);

    // In return statement
    if (checkInList(list, 5)) {
      print('check');
    }

    // In while loop
    while (list.contains(6)) {
      break;
    }

    // In ternary expression
    var message = list.contains(7) ? 'found' : 'not found';
    var message2 = !list.contains(8) ? 'not found' : 'found';

    // Combined with logical operators
    if (list.contains(9) && list.length > 5) {
      print('found and long');
    }

    if (!list.contains(10) || list.isEmpty) {
      print('not found or empty');
    }
  }

  bool checkInList(List<int> list, int value) {
    return list.contains(value);
  }

  void testIndexOfForSpecificIndex() {
    final list = [1, 2, 3, 4, 5];

    // Checking for specific index (not -1) - this is OK
    if (list.indexOf(1) == 0) {
      print('at start');
    }

    if (list.indexOf(2) == 1) {
      print('at index 1');
    }

    if (list.indexOf(3) != 0) {
      print('not at start');
    }

    // Using indexOf to get the actual index
    var index = list.indexOf(4);
    if (index > 0) {
      print('found after start');
    }

    // Comparing indexOf results
    if (list.indexOf(5) > list.indexOf(3)) {
      print('5 comes after 3');
    }

    // Using indexOf for position-based logic
    var pos = list.indexOf(2);
    if (pos >= 0 && pos < 3) {
      print('in first three positions');
    }
  }

  void testStringContains() {
    final str = 'hello world';

    // Using contains directly - this is good
    if (str.contains('hello')) {
      print('found');
    }

    if (!str.contains('goodbye')) {
      print('not found');
    }

    // Using contains with pattern
    if (str.contains(RegExp(r'\d+'))) {
      print('has digits');
    }
  }

  void testOtherComparisons() {
    final list = [1, 2, 3];

    // Comparing with other values (not -1)
    if (list.length == 3) {
      print('has 3 elements');
    }

    // Other method comparisons
    if (list.first == 1) {
      print('first is 1');
    }

    if (list.last != 5) {
      print('last is not 5');
    }
  }

  void testIndexOfReturnValue() {
    final list = ['a', 'b', 'c'];

    // Using indexOf return value directly (not comparing)
    var index = list.indexOf('b');
    print('Index: $index');

    // Passing indexOf to function
    processIndex(list.indexOf('a'));

    // Using in expressions that don't compare with -1
    var doubled = list.indexOf('c') * 2;
    print(doubled);
  }

  void processIndex(int index) {
    print('Processing index: $index');
  }

  void testComplexExpressions() {
    final list = ['a', 'b', 'c'];

    // Using contains in method chain
    if (list.map((e) => e.toUpperCase()).toList().contains('A')) {
      print('found');
    }

    // In assert with contains
    assert(list.contains('a'));
    assert(!list.contains('d'));
  }
}
