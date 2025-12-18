// Test cases that should trigger the avoid_complex_loop_conditions lint

void test() {
  final List<int> items = [1, 2, 3, 4, 5];
  bool done = false;
  final int max = 10;

  // Case 1: For loop with compound condition using &&
  // expect_lint: avoid_complex_loop_conditions
  for (var i = 0; i < max && !done; i++) {
    print(i);
  }

  // Case 2: For loop with compound condition using ||
  // expect_lint: avoid_complex_loop_conditions
  for (var i = 0; i < max || done; i++) {
    print(i);
  }

  // Case 3: While loop with compound condition &&
  var index = 0;
  // expect_lint: avoid_complex_loop_conditions
  while (index < items.length && !done) {
    print(items[index]);
    index++;
  }

  // Case 4: While loop with compound condition ||
  index = 0;
  // expect_lint: avoid_complex_loop_conditions
  while (index >= items.length || done) {
    done = true;
  }

  // Case 5: Do-while loop with compound condition &&
  index = 0;
  do {
    print(items[index]);
    index++;
    // expect_lint: avoid_complex_loop_conditions
  } while (index < items.length && !done);

  // Case 6: Do-while loop with compound condition ||
  index = 0;
  do {
    print(items[index]);
    index++;
    // expect_lint: avoid_complex_loop_conditions
  } while (index < items.length || done);

  // Case 7: For loop with parenthesized compound condition
  // expect_lint: avoid_complex_loop_conditions
  for (var i = 0; (i < max && !done); i++) {
    print(i);
  }

  // Case 8: Complex condition with multiple checks
  index = 0;
  // expect_lint: avoid_complex_loop_conditions
  while (index < items.length && items[index] > 0) {
    index++;
  }
}
