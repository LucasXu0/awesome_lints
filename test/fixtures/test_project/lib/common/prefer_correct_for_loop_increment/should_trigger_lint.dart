// Test cases that should trigger the prefer_correct_for_loop_increment lint

void test() {
  var j = 0;

  // Case 1: Basic wrong increment with postfix
  // expect_lint: prefer_correct_for_loop_increment
  for (var i = 0; i < 10; j++) {
    print(i);
  }

  // Case 2: Wrong decrement with postfix
  // expect_lint: prefer_correct_for_loop_increment
  for (var i = 10; i > 0; j--) {
    print(i);
  }

  // Case 3: Wrong increment with prefix
  // expect_lint: prefer_correct_for_loop_increment
  for (var i = 0; i < 10; ++j) {
    print(i);
  }

  // Case 4: Wrong decrement with prefix
  // expect_lint: prefer_correct_for_loop_increment
  for (var i = 10; i > 0; --j) {
    print(i);
  }

  // Case 5: Wrong increment with assignment
  // expect_lint: prefer_correct_for_loop_increment
  for (var i = 0; i < 10; j += 1) {
    print(i);
  }

  // Case 6: Wrong decrement with assignment
  // expect_lint: prefer_correct_for_loop_increment
  for (var i = 10; i > 0; j -= 1) {
    print(i);
  }

  // Case 7: Wrong variable with regular assignment
  // expect_lint: prefer_correct_for_loop_increment
  for (var i = 0; i < 10; j = j + 1) {
    print(i);
  }

  // Case 8: Nested loop with wrong increment (outer loop)
  // expect_lint: prefer_correct_for_loop_increment
  for (var i = 0; i < 10; j++) {
    for (var k = 0; k < 5; k++) {
      print('$i,$k');
    }
  }

  // Case 9: Nested loop with wrong increment (inner loop)
  var x = 0;
  for (var i = 0; i < 10; i++) {
    // expect_lint: prefer_correct_for_loop_increment
    for (var k = 0; k < 5; x++) {
      print('$i,$k');
    }
  }

  // Case 10: For loop with expression initialization
  var i = 0;
  // expect_lint: prefer_correct_for_loop_increment
  for (i = 0; i < 10; j++) {
    print(i);
  }

  // Case 11: Multiple updaters with one wrong
  // expect_lint: prefer_correct_for_loop_increment
  for (var a = 0; a < 10; a++, j++) {
    print(a);
  }

  // Case 12: Multiple updaters both wrong
  var b = 0;
  // expect_lint: prefer_correct_for_loop_increment
  for (var a = 0; a < 10; b++, j++) {
    print(a);
  }
}
