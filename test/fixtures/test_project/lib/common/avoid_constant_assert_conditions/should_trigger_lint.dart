// Test cases that should trigger the avoid_constant_assert_conditions lint

const int constValue = 5;
const bool constBool = true;

void test() {
  // Case 1: Assert with true literal
  // expect_lint: avoid_constant_assert_conditions
  assert(true);

  // Case 2: Assert with false literal
  // expect_lint: avoid_constant_assert_conditions
  assert(false);

  // Case 3: Assert with integer literal
  // expect_lint: avoid_constant_assert_conditions
  assert(1);

  // Case 4: Assert with zero (falsy in some languages, but truthy in Dart)
  // expect_lint: avoid_constant_assert_conditions
  assert(0);

  // Case 5: Assert with double literal
  // expect_lint: avoid_constant_assert_conditions
  assert(3.14);

  // Case 6: Assert with string literal
  // expect_lint: avoid_constant_assert_conditions
  assert('not empty');

  // Case 7: Assert with empty string literal
  // expect_lint: avoid_constant_assert_conditions
  assert('');

  // Case 8: Assert with null literal
  // expect_lint: avoid_constant_assert_conditions
  assert(null);

  // Case 9: Assert with binary expression of constants
  // expect_lint: avoid_constant_assert_conditions
  assert(5 > 0);

  // Case 10: Assert with const list (not const variable - too complex to detect)
  // expect_lint: avoid_constant_assert_conditions
  assert(const []);

  print('test');
}

void testWithConstVariable() {
  // These cases with const variables are too complex to detect reliably
  // Our simplified implementation focuses on literals
  assert(constValue > 0); // Valid: involves runtime evaluation
  assert(constBool); // Valid: const variable detection is complex

  // Case 11: Assert with parenthesized constant
  // expect_lint: avoid_constant_assert_conditions
  assert((true));

  // Case 12: Assert with negation of constant
  // expect_lint: avoid_constant_assert_conditions
  assert(!false);

  // Case 13: Assert with const list
  // expect_lint: avoid_constant_assert_conditions
  assert(const [1, 2, 3]);

  // Case 14: Assert with binary expression of constants
  // expect_lint: avoid_constant_assert_conditions
  assert(1 + 1 == 2);

  print('test');
}
