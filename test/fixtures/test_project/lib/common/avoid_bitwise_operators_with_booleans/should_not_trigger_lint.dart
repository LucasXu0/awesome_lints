// This file should NOT trigger the avoid_bitwise_operators_with_booleans lint

void fn() {
  var x = true;

  // Using logical operators is correct
  // ignore: dead_code
  if (x && false) {
    print('test');
  }

  // ignore: dead_code
  if (x || false) {
    print('test');
  }

  // Bitwise operators with integers are fine
  // ignore: unused_local_variable
  var a = 5 & 3;
  // ignore: unused_local_variable
  var b = 5 | 3;
}
