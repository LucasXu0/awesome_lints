// ignore_for_file: dead_code, unused_local_variable

class Test {
  bool flag = true;
  bool? nullableFlag;

  void method() {
    // Comparing to true with ==
    // expect_lint: no_boolean_literal_compare
    var result1 = flag == true;

    // Comparing to false with ==
    // expect_lint: no_boolean_literal_compare
    var result2 = flag == false;

    // Comparing to true with !=
    // expect_lint: no_boolean_literal_compare
    var result3 = flag != true;

    // Comparing to false with !=
    // expect_lint: no_boolean_literal_compare
    var result4 = flag != false;

    // Literal on the left side with ==
    // expect_lint: no_boolean_literal_compare
    var result5 = flag == true;

    // Literal on the left side with !=
    // expect_lint: no_boolean_literal_compare
    var result6 = flag != false;

    // In if statement
    // expect_lint: no_boolean_literal_compare
    if (flag == true) {
      print('true');
    }

    // In if statement with false
    // expect_lint: no_boolean_literal_compare
    if (flag == false) {
      print('false');
    }

    // In while loop
    // expect_lint: no_boolean_literal_compare
    while (flag != false) {
      break;
    }

    // In ternary expression
    // expect_lint: no_boolean_literal_compare
    var value = flag == true ? 'yes' : 'no';

    // With method call
    // expect_lint: no_boolean_literal_compare
    if (isValid() == true) {
      print('valid');
    }

    // With method call on the left
    // expect_lint: no_boolean_literal_compare
    if (isValid() == false) {
      print('invalid');
    }

    // Nested in expression
    // expect_lint: no_boolean_literal_compare
    var complex = (flag == true) && isValid();
  }

  bool isValid() => true;

  // In function return
  bool check1() {
    // expect_lint: no_boolean_literal_compare
    return flag == false;
  }

  bool check2() {
    // expect_lint: no_boolean_literal_compare
    return flag == true;
  }
}

// Top-level function
bool compare(bool value) {
  // expect_lint: no_boolean_literal_compare
  return value != false;
}

// With assert
void testAssert(bool condition) {
  // expect_lint: no_boolean_literal_compare
  assert(condition == true);
}

// With nullable boolean (still triggers)
void testNullable(bool? value) {
  // expect_lint: no_boolean_literal_compare
  if (value == true) {
    print('true');
  }

  // expect_lint: no_boolean_literal_compare
  if (value == false) {
    print('false');
  }
}
