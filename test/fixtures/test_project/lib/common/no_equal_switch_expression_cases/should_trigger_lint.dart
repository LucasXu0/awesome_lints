// ignore_for_file: dead_code, unused_local_variable, non_exhaustive_switch_expression

void basicDuplicateExpression() {
  final value = 1;

  // expect_lint: no_equal_switch_expression_cases
  final result = switch (value) {
    1 => 'one',
    2 => 'duplicate',
    3 => 'duplicate',
  };
}

void multipleDuplicates() {
  final value = 5;

  // expect_lint: no_equal_switch_expression_cases
  final result = switch (value) {
    1 => 'first',
    2 => 'same',
    3 => 'same',
    4 => 'same',
  };
}

void duplicateComplexExpression() {
  final value = 10;

  // expect_lint: no_equal_switch_expression_cases
  final result = switch (value) {
    1 => value * 2 + 5,
    2 => value - 3,
    3 => value * 2 + 5,
  };
}

void duplicateStringLiteral() {
  final str = 'test';

  // expect_lint: no_equal_switch_expression_cases
  final result = switch (str) {
    'a' => 'alpha',
    'b' => 'beta',
    'c' => 'alpha',
  };
}

void duplicateMethodCall() {
  final str = 'test';

  // expect_lint: no_equal_switch_expression_cases
  final result = switch (str) {
    'a' => str.toUpperCase(),
    'b' => str.toLowerCase(),
    'c' => str.toUpperCase(),
  };
}

void duplicateNumberLiteral() {
  final value = 5;

  // expect_lint: no_equal_switch_expression_cases
  final result = switch (value) {
    1 => 100,
    2 => 200,
    3 => 100,
  };
}

void duplicateBooleanExpression() {
  final value = true;

  // expect_lint: no_equal_switch_expression_cases
  final result = switch (value) {
    true => 1,
    false => 2,
  };
}

void duplicateWithWildcard() {
  final value = 10;

  // expect_lint: no_equal_switch_expression_cases
  final result = switch (value) {
    1 => 'one',
    2 => 'two',
    _ => 'one',
  };
}

sealed class Shape {}

class Circle extends Shape {}

class Square extends Shape {}

class Triangle extends Shape {}

void duplicatePatternMatching() {
  final shape = Circle();

  // expect_lint: no_equal_switch_expression_cases
  final result = switch (shape) {
    Circle() => 'round',
    Square() => 'angular',
    Triangle() => 'round',
  };
}

void duplicateWithVariable() {
  final value = 5;

  // expect_lint: no_equal_switch_expression_cases
  final result = switch (value) {
    1 => value + 10,
    2 => value * 2,
    3 => value + 10,
  };
}

// ignore_for_file: constant_pattern_never_matches_value_type
void duplicateNullCheck() {
  int? value = 5;

  // expect_lint: no_equal_switch_expression_cases
  final result = switch (value) {
    null => 0,
    1 => 100,
    _ => 0,
  };
}

void duplicateListLiteral() {
  final value = 1;

  // expect_lint: no_equal_switch_expression_cases
  final result = switch (value) {
    1 => [1, 2, 3],
    2 => [4, 5, 6],
    3 => [1, 2, 3],
  };
}

void duplicateMapLiteral() {
  final value = 1;

  // expect_lint: no_equal_switch_expression_cases
  final result = switch (value) {
    1 => {'key': 'value'},
    2 => {'other': 'data'},
    3 => {'key': 'value'},
  };
}

void duplicateTernary() {
  final value = 5;

  // expect_lint: no_equal_switch_expression_cases
  final result = switch (value) {
    1 => value > 0 ? 'positive' : 'negative',
    2 => value == 0 ? 'zero' : 'nonzero',
    3 => value > 0 ? 'positive' : 'negative',
  };
}
