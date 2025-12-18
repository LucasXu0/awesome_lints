// Test cases that should NOT trigger the avoid_complex_arithmetic_expressions lint

// ignore_for_file: dead_code

void test() {
  final int a = 1, b = 2, c = 3, d = 4, e = 5, f = 6;

  // Valid: Exactly 6 operations (at threshold)
  final result1 = a + b + c + d + e + f;

  // Valid: 5 operations
  final result2 = a + b + c + d + e;

  // Valid: Simple addition (1 operation)
  final result3 = a + b;

  // Valid: Simple multiplication (1 operation)
  final result4 = a * b;

  // Valid: Two operations
  final result5 = a + b - c;

  // Valid: Three operations with parentheses
  final result6 = (a + b) * (c + d);

  // Valid: Mixed operators with 4 operations
  final result7 = a * b + c / d;

  // Valid: Modulo with 3 operations
  final result8 = a % b + c % d;

  // Valid: Integer division with 2 operations
  final result9 = a ~/ b + c;

  // Valid: No arithmetic operations
  final result10 = a;

  // Valid: Comparison operations (not arithmetic)
  final result11 = a > b && c < d;

  // Valid: Logical operations (not arithmetic)
  final bool p = true, q = false;
  final result12 = p || q;

  // Valid: String concatenation (not arithmetic in number sense)
  final result13 = 'a' + 'b' + 'c';

  // Valid: Method call (not arithmetic)
  final list = [1, 2, 3];
  final result14 = list.length;

  print(
      '$result1 $result2 $result3 $result4 $result5 $result6 $result7 $result8 $result9 $result10 $result11 $result12 $result13 $result14');
}
