// Test cases that should trigger the avoid_collapsible_if lint

// ignore_for_file: dead_code

void test() {
  final bool a = true;
  final bool b = true;
  final bool c = true;

  // Case 1: Basic nested if with single inner statement
  // expect_lint: avoid_collapsible_if
  if (a) {
    if (b) {
      print('both true');
    }
  }

  // Case 2: Nested if with complex conditions
  // expect_lint: avoid_collapsible_if
  if (a && b) {
    if (c) {
      print('all true');
    }
  }

  // Case 3: Nested if with method calls
  final list = [1, 2, 3];
  // expect_lint: avoid_collapsible_if
  if (list.isNotEmpty) {
    if (list.length > 2) {
      print('has items');
    }
  }

  // Case 4: Nested if with negations
  // expect_lint: avoid_collapsible_if
  if (!a) {
    if (!b) {
      print('both false');
    }
  }

  // Case 5: Nested if with parenthesized condition
  // expect_lint: avoid_collapsible_if
  if ((a)) {
    if ((b)) {
      print('both true');
    }
  }

  // Case 6: Nested if with multiple statements in inner if
  // expect_lint: avoid_collapsible_if
  if (a) {
    if (b) {
      print('line 1');
      print('line 2');
    }
  }
}
