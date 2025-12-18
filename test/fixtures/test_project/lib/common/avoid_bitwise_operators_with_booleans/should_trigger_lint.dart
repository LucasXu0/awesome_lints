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
  // ignore: unused_local_variable
  var result = true & false;
}
