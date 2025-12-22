class Test {
  bool flag = true;
  bool? nullableFlag;

  void method() {
    // Using boolean value directly
    var result1 = flag;

    // Using negation
    var result2 = !flag;

    // In if statement without comparison
    if (flag) {
      print('true');
    }

    // Negated in if statement
    if (!flag) {
      print('false');
    }

    // In while loop
    while (flag) {
      break;
    }

    // In ternary expression
    var value = flag ? 'yes' : 'no';

    // With method call
    if (isValid()) {
      print('valid');
    }

    // Negated method call
    if (!isValid()) {
      print('invalid');
    }

    // Combined with logical operators
    var complex = flag && isValid();
  }

  bool isValid() => true;

  // Direct return
  bool check1() {
    return flag;
  }

  // Negated return
  bool check2() {
    return !flag;
  }
}

// Top-level function
bool compare(bool value) {
  return !value;
}

// With assert
void testAssert(bool condition) {
  assert(condition);
}

// Proper null check for nullable boolean
void testNullable(bool? value) {
  if (value != null && value) {
    print('true');
  }

  if (value != null && !value) {
    print('false');
  }

  // Using null-aware operator
  if (value ?? false) {
    print('has value or default');
  }
}

// Comparing non-boolean values
void nonBooleanComparisons() {
  var x = 5;
  var y = 10;

  // These are fine - not boolean literals
  if (x == y) {
    print('equal');
  }

  var str = 'hello';
  if (str == 'world') {
    print('match');
  }
}
