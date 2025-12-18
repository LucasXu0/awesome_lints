// Test cases that should trigger the avoid_complex_conditions lint

// ignore_for_file: dead_code

void test() {
  final bool a = true, b = false, c = true, d = false;
  final List<int> list = [1, 2, 3];
  final int value = 5;

  // Case 1: Multiple logical operators with method calls (complexity > 10)
  // expect_lint: avoid_complex_conditions
  if ((list.contains(1) && list.isNotEmpty) || (a && b && c) || (d && !a)) {
    print('complex');
  }

  // Case 2: Deeply nested conditions with parentheses
  // expect_lint: avoid_complex_conditions
  if (((a && b) || (c && d)) && ((list.length > 2) || (value == 5))) {
    print('complex');
  }

  // Case 3: Many conditions combined
  // expect_lint: avoid_complex_conditions
  if (a && b && c && d && list.isNotEmpty && list.length > 0) {
    print('complex');
  }

  // Case 4: Complex with mixed operators and negations
  // expect_lint: avoid_complex_conditions
  if ((!a || !b) && (c || d) && list.where((e) => e > 0).isNotEmpty) {
    print('complex');
  }

  // Case 5: Complex condition in if with loop-like structure
  // expect_lint: avoid_complex_conditions
  if ((a && b && c) || (d && list.length > 5 && value < 10)) {
    print('complex');
  }

  // Case 6: Ternary within condition
  // expect_lint: avoid_complex_conditions
  if ((a ? (b && c) : (d && !c)) && list.isNotEmpty && value > 0) {
    print('complex');
  }

  // Case 7: Multiple method invocations and comparisons
  // expect_lint: avoid_complex_conditions
  if (list.any((e) => e > 0) && list.every((e) => e < 10) && (a || b || c)) {
    print('complex');
  }
}
