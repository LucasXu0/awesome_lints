// Test cases that should NOT trigger the avoid_conditions_with_boolean_literals lint

void test() {
  final bool condition1 = true;
  final bool condition2 = false;
  final someSet = {1, 2, 3};

  // Valid: No boolean literals in logical expressions
  if (condition1 && condition2) {
    print('Both conditions');
  }

  // Valid: Using boolean variables with OR
  if (condition1 || condition2) {
    print('Either condition');
  }

  // Valid: Method calls without boolean literals
  if (someSet.contains(1) && someSet.isNotEmpty) {
    print('Valid checks');
  }

  // Valid: Complex expressions without boolean literals
  if ((condition1 || condition2) && someSet.isNotEmpty) {
    print('Complex valid');
  }

  // Valid: Simple boolean variable
  if (condition1) {
    print('Simple condition');
  }

  // Valid: Boolean literal alone (not in binary expression)
  if (true) {
    print('Always true, but not in binary expression');
  }

  // Valid: Equality checks (not logical operators)
  if (condition1 == true) {
    print('Equality check, not logical operator');
  }

  // Valid: Assignment with boolean
  final result = true;
  print(result);

  // Valid: Comparison operators
  if (someSet.length > 0 && someSet.length < 10) {
    print('Range check');
  }

  // Valid: Negation without logical operators
  if (!condition1) {
    print('Negated');
  }
}
