// Test cases that should NOT trigger the avoid_complex_conditions lint

void test() {
  final bool a = true, b = false, c = true;
  final List<int> list = [1, 2, 3];
  final int value = 5;

  // Valid: Simple condition
  if (a) {
    print('simple');
  }

  // Valid: Two conditions
  if (a && b) {
    print('simple');
  }

  // Valid: Three conditions
  if (a && b && c) {
    print('acceptable');
  }

  // Valid: Simple OR condition
  if (a || b) {
    print('simple');
  }

  // Valid: Simple negation
  if (!a) {
    print('simple');
  }

  // Valid: Simple comparison
  if (value > 0) {
    print('simple');
  }

  // Valid: Method call with single condition
  if (list.isNotEmpty) {
    print('simple');
  }

  // Valid: Two method calls
  if (list.isNotEmpty && list.length > 0) {
    print('acceptable');
  }

  // Valid: Parenthesized simple condition
  if ((a && b) || c) {
    print('acceptable');
  }

  // Valid: Simple while loop condition
  while (a && b) {
    break;
  }

  // Valid: Simple ternary
  final result = a ? 1 : 2;
  print(result);

  // Valid: Simple conditional expression in if
  if (a ? b : c) {
    print('simple ternary');
  }

  // Valid: Property access with simple condition
  if (list.length > 0 && a) {
    print('acceptable');
  }

  // Valid: Null check
  if (list.isEmpty) {
    print('simple');
  }

  // Valid: Contains check with condition
  if (list.contains(1) && a) {
    print('acceptable');
  }
}
