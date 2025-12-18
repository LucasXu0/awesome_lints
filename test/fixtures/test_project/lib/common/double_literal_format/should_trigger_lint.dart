// Test cases that should trigger double_literal_format lint
// ignore_for_file: dead_code, unused_local_variable

void testDoubleLiterals() {
  // expect_lint: double_literal_format
  var a = .257; // Missing leading 0

  // expect_lint: double_literal_format
  var b = 0.210; // Redundant trailing 0

  // expect_lint: double_literal_format
  var c = 05.23; // Unnecessary leading 0

  // expect_lint: double_literal_format
  var d = 1.00; // Multiple trailing zeros

  // expect_lint: double_literal_format
  var e = .5; // Missing leading 0

  // expect_lint: double_literal_format
  var f = 3.1400; // Multiple trailing zeros
}
