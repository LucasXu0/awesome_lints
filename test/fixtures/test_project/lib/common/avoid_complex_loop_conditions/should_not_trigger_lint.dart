// Test cases that should NOT trigger the avoid_complex_loop_conditions lint

void test() {
  final List<int> items = [1, 2, 3, 4, 5];
  bool done = false;
  final int max = 10;

  // Valid: Simple for loop with single condition
  for (var i = 0; i < max; i++) {
    print(i);
  }

  // Valid: For loop with no condition
  for (var i = 0;; i++) {
    if (i >= max) break;
    print(i);
  }

  // Valid: While loop with simple condition
  var index = 0;
  while (index < items.length) {
    print(items[index]);
    index++;
  }

  // Valid: While loop with single boolean variable
  while (done) {
    done = false;
  }

  // Valid: While loop with negation (not a binary expression)
  while (!done) {
    done = true;
  }

  // Valid: Do-while loop with simple condition
  index = 0;
  do {
    print(items[index]);
    index++;
  } while (index < items.length);

  // Valid: For loop with comparison only
  for (var i = 0; i < items.length; i++) {
    print(items[i]);
  }

  // Valid: While loop with method call
  while (items.isEmpty) {
    items.first;
  }

  // Valid: While loop with equality check
  index = 0;
  while (index == 0) {
    index++;
  }

  // Valid: For-in loop (no condition)
  for (final item in items) {
    print(item);
  }

  // Valid: Do-while with method call condition
  do {
    print('running');
  } while (items.isNotEmpty);
}
