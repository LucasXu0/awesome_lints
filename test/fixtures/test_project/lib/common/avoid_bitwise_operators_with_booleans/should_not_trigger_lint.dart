// This file should NOT trigger the avoid_bitwise_operators_with_booleans lint

void fn() {
  var x = true;
  var y = false;

  // Using logical operators is correct

  if (x && y) {
    print('test');
  }

  if (x || y) {
    print('test');
  }

  // Bitwise operators with integers are fine

  var a = 5 & 3;

  var b = 5 | 3;
}
