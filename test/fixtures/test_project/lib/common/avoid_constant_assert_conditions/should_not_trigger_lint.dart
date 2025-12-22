// Test cases that should NOT trigger the avoid_constant_assert_conditions lint

void test() {
  final int value = 5;
  final bool condition = true;
  final List<int> list = [1, 2, 3];
  final String? nullableString = 'test';

  // Valid: Assert with variable condition
  assert(value > 0);

  // Valid: Assert with boolean variable
  assert(condition);

  // Valid: Assert with method call
  assert(list.isNotEmpty);

  // Valid: Assert with property access
  assert(list.length > 0);

  // Valid: Assert with complex expression
  assert(value > 0 && condition);

  // Valid: Assert with null check
  assert(nullableString != null);

  // Valid: Assert with negation of variable
  assert(!condition);

  // Valid: Assert with function call
  assert(_checkCondition());

  // Valid: Assert with comparison
  assert(value == 5);

  // Valid: Assert with contains check
  assert(list.contains(1));

  // Valid: Assert with range check
  assert(value >= 0 && value <= 10);

  // Valid: Assert with multiple conditions
  assert(condition && list.isNotEmpty);

  // Valid: Assert with ternary using variables
  assert(condition ? value > 0 : value < 0);

  print('test');
}

bool _checkCondition() => true;
