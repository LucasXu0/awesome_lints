// Test cases that should trigger the avoid_complex_arithmetic_expressions lint

void test() {
  final int a = 1, b = 2, c = 3, d = 4, e = 5, f = 6, g = 7, h = 8;

  // Case 1: 7 operations (exceeds threshold of 6)
  // expect_lint: avoid_complex_arithmetic_expressions
  final result1 = a + a + a + b + b + b + b + c;

  // Case 2: Mixed operators with 7 operations
  // expect_lint: avoid_complex_arithmetic_expressions
  final result2 = a + b - c + d * e / f + g - h;

  // Case 3: Many additions (8 operations)
  // expect_lint: avoid_complex_arithmetic_expressions
  final result3 = a + b + c + d + e + f + g + h;

  // Case 4: Complex calculation with parentheses (8 operations)
  // expect_lint: avoid_complex_arithmetic_expressions
  final result4 = (a + b) * (c + d) + (e + f) - (g + h) + a;

  // Case 5: Mixed multiplication and addition (8 operations)
  // expect_lint: avoid_complex_arithmetic_expressions
  final result5 = a * b + c * d + e * f + g * h;

  // Case 6: Division and subtraction (7 operations)
  // expect_lint: avoid_complex_arithmetic_expressions
  final result6 = a / b - c / d - e / f - g / h;

  // Case 7: Using modulo operator (7 operations)
  // expect_lint: avoid_complex_arithmetic_expressions
  final result7 = a % b + c % d + e % f + g % h;

  // Case 8: Using integer division ~/ (7 operations)
  // expect_lint: avoid_complex_arithmetic_expressions
  final result8 = a ~/ b + c ~/ d + e ~/ f + g + h;

  print(
    '$result1 $result2 $result3 $result4 $result5 $result6 $result7 $result8',
  );
}
