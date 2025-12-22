// Test cases that should NOT trigger the prefer_correct_for_loop_increment lint

void test() {
  final List<int> items = [1, 2, 3, 4, 5];

  // Valid: Basic for loop with correct postfix increment
  for (var i = 0; i < 10; i++) {
    print(i);
  }

  // Valid: Basic for loop with correct postfix decrement
  for (var i = 10; i > 0; i--) {
    print(i);
  }

  // Valid: Basic for loop with correct prefix increment
  for (var i = 0; i < 10; ++i) {
    print(i);
  }

  // Valid: Basic for loop with correct prefix decrement
  for (var i = 10; i > 0; --i) {
    print(i);
  }

  // Valid: For loop with correct compound assignment increment
  for (var i = 0; i < 10; i += 1) {
    print(i);
  }

  // Valid: For loop with correct compound assignment decrement
  for (var i = 10; i > 0; i -= 1) {
    print(i);
  }

  // Valid: For loop with correct assignment
  for (var i = 0; i < 10; i = i + 1) {
    print(i);
  }

  // Valid: For loop with step of 2
  for (var i = 0; i < 10; i += 2) {
    print(i);
  }

  // Valid: For loop counting backwards
  for (var i = 10; i >= 0; i -= 2) {
    print(i);
  }

  // Valid: For loop with no updater
  for (var i = 0; i < 10;) {
    print(i);
    i++;
  }

  // Valid: For-in loop (different type of loop)
  for (final item in items) {
    print(item);
  }

  // Valid: Nested loops with correct increments
  for (var i = 0; i < 10; i++) {
    for (var j = 0; j < 5; j++) {
      print('$i,$j');
    }
  }

  // Valid: For loop with expression initialization
  var i = 0;
  for (i = 0; i < 10; i++) {
    print(i);
  }

  // Valid: Multiple updaters updating the declared variable
  for (var j = 0; j < 10; j++, j++) {
    print(j);
  }

  // Valid: For loop with no condition
  for (var k = 0; ; k++) {
    if (k >= 10) break;
    print(k);
  }

  // Valid: For loop with complex assignment but correct variable
  for (var x = 0; x < 100; x = x + 10) {
    print(x);
  }

  // Valid: For loop with multiplication assignment
  for (var y = 1; y < 1000; y *= 2) {
    print(y);
  }

  // Valid: Multiple declared variables with updater for one of them
  for (var a = 0, b = 10; a < b; a++) {
    print('$a,$b');
  }

  // Valid: Multiple declared variables with updaters for both
  for (var a = 0, b = 10; a < b; a++, b--) {
    print('$a,$b');
  }
}
