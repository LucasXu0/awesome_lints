// Test cases that should trigger the avoid_conditions_with_boolean_literals lint

void test() {
  final bool condition = true;
  final someSet = {1, 2, 3};

  // Case 1: AND with true literal (redundant)
  // expect_lint: avoid_conditions_with_boolean_literals
  if (someSet.contains(1) && true) {
    print('Found');
  }

  // Case 2: OR with true literal (always true)
  // expect_lint: avoid_conditions_with_boolean_literals
  if (condition || true) {
    print('Always executed');
  }

  // Case 3: AND with false literal (always false)
  // expect_lint: avoid_conditions_with_boolean_literals
  if (condition && false) {
    print('Never executed');
  }

  // Case 4: OR with false literal (redundant)
  // expect_lint: avoid_conditions_with_boolean_literals
  if (someSet.isEmpty || false) {
    print('Check');
  }

  // Case 5: Boolean literal on left side with AND
  // expect_lint: avoid_conditions_with_boolean_literals
  if (condition && true) {
    print('Redundant');
  }

  // Case 6: Boolean literal on left side with OR
  // expect_lint: avoid_conditions_with_boolean_literals
  if (condition || false) {
    print('Redundant');
  }

  // Case 7: Complex expression with boolean literal
  // expect_lint: avoid_conditions_with_boolean_literals
  final result = someSet.isNotEmpty && true;
  print(result);

  // Case 8: Multiple conditions with boolean literal
  // expect_lint: avoid_conditions_with_boolean_literals
  if ((condition || false) && someSet.isNotEmpty) {
    print('Complex');
  }
}
