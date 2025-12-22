// This file should trigger the avoid_bitwise_operators_with_booleans lint

void fn() {
  var x = true;

  // expect_lint: avoid_bitwise_operators_with_booleans
  if (x & false) {
    print('test');
  }

  // expect_lint: avoid_bitwise_operators_with_booleans
  if (x | false) {
    print('test');
  }

  // expect_lint: avoid_bitwise_operators_with_booleans
  var result1 = true & false;

  // expect_lint: avoid_bitwise_operators_with_booleans
  var result2 = true | false;
}
