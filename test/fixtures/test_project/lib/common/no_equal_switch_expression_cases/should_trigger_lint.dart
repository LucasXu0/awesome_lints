void basicDuplicateExpression() {
  final value = 1;

  final result = switch (value) {
    1 => 'one',
    2 => 'duplicate',
    // expect_lint: no_equal_switch_expression_cases
    3 => 'duplicate',
  };
}

void multipleDuplicates() {
  final value = 5;

  final result = switch (value) {
    1 => 'first',
    2 => 'same',
    // expect_lint: no_equal_switch_expression_cases
    3 => 'same',
    // expect_lint: no_equal_switch_expression_cases
    4 => 'same',
  };
}

void duplicateComplexExpression() {
  final value = 10;

  final result = switch (value) {
    1 => value * 2 + 5,
    2 => value - 3,
    // expect_lint: no_equal_switch_expression_cases
    3 => value * 2 + 5,
  };
}

void duplicateStringLiteral() {
  final str = 'test';

  final result = switch (str) {
    'a' => 'alpha',
    'b' => 'beta',
    // expect_lint: no_equal_switch_expression_cases
    'c' => 'alpha',
  };
}

void duplicateMethodCall() {
  final str = 'test';

  final result = switch (str) {
    'a' => str.toUpperCase(),
    'b' => str.toLowerCase(),
    // expect_lint: no_equal_switch_expression_cases
    'c' => str.toUpperCase(),
  };
}

void duplicateNumberLiteral() {
  final value = 5;

  final result = switch (value) {
    1 => 100,
    2 => 200,
    // expect_lint: no_equal_switch_expression_cases
    3 => 100,
  };
}

void duplicateBooleanExpression() {
  final value = true;

  final result = switch (value) {
    true => 1,
    false => 2,
  };
}

void duplicateWithWildcard() {
  final value = 10;

  final result = switch (value) {
    1 => 'one',
    2 => 'two',
    // expect_lint: no_equal_switch_expression_cases
    _ => 'one',
  };
}

sealed class Shape {}

class Circle extends Shape {}

class Square extends Shape {}

class Triangle extends Shape {}

void duplicatePatternMatching() {
  final shape = Circle();

  final result = switch (shape) {
    Circle() => 'round',
    Square() => 'angular',
    // expect_lint: no_equal_switch_expression_cases
    Triangle() => 'round',
  };
}

void duplicateWithVariable() {
  final value = 5;

  final result = switch (value) {
    1 => value + 10,
    2 => value * 2,
    // expect_lint: no_equal_switch_expression_cases
    3 => value + 10,
  };
}

void duplicateNullCheck() {
  int? value = 5;

  final result = switch (value) {
    null => 0,
    1 => 100,
    // expect_lint: no_equal_switch_expression_cases
    _ => 0,
  };
}

void duplicateListLiteral() {
  final value = 1;

  final result = switch (value) {
    1 => [1, 2, 3],
    2 => [4, 5, 6],
    // expect_lint: no_equal_switch_expression_cases
    3 => [1, 2, 3],
  };
}

void duplicateMapLiteral() {
  final value = 1;

  final result = switch (value) {
    1 => {'key': 'value'},
    2 => {'other': 'data'},
    // expect_lint: no_equal_switch_expression_cases
    3 => {'key': 'value'},
  };
}

void duplicateTernary() {
  final value = 5;

  final result = switch (value) {
    1 => value > 0 ? 'positive' : 'negative',
    2 => value == 0 ? 'zero' : 'nonzero',
    // expect_lint: no_equal_switch_expression_cases
    3 => value > 0 ? 'positive' : 'negative',
  };
}
