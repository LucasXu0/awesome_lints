// ignore_for_file: dead_code, unused_local_variable, non_exhaustive_switch_expression

void allDifferentExpressions() {
  final value = 1;

  final result = switch (value) {
    1 => 'one',
    2 => 'two',
    3 => 'three',
  };
}

void combinedPatternsWithSameExpression() {
  final value = 5;

  final result = switch (value) {
    1 || 2 => 'small',
    3 || 4 => 'medium',
    _ => 'large',
  };
}

void differentComplexExpressions() {
  final value = 10;

  final result = switch (value) {
    1 => value * 2 + 5,
    2 => value * 3 + 5,
    3 => value * 2 - 5,
  };
}

void differentStringLiterals() {
  final str = 'test';

  final result = switch (str) {
    'a' => 'alpha',
    'b' => 'beta',
    'c' => 'gamma',
  };
}

void differentMethodCalls() {
  final str = 'test';

  final result = switch (str) {
    'a' => str.toUpperCase(),
    'b' => str.toLowerCase(),
    'c' => str.trim(),
  };
}

void differentNumberLiterals() {
  final value = 5;

  final result = switch (value) {
    1 => 100,
    2 => 200,
    3 => 300,
  };
}

void singleCase() {
  final value = 5;

  final result = switch (value) {
    _ => 'default',
  };
}

sealed class Shape {}

class Circle extends Shape {}

class Square extends Shape {}

class Triangle extends Shape {}

void differentPatternMatching() {
  final shape = Circle();

  final result = switch (shape) {
    Circle() => 'round',
    Square() => 'square',
    Triangle() => 'triangular',
  };
}

void differentWithVariable() {
  final value = 5;

  final result = switch (value) {
    1 => value + 10,
    2 => value * 2,
    3 => value - 5,
  };
}

void differentNullHandling() {
  int? value = 5;

  final result = switch (value) {
    1 => 100,
    _ => 999,
  };
}

void differentListLiterals() {
  final value = 1;

  final result = switch (value) {
    1 => [1, 2, 3],
    2 => [4, 5, 6],
    3 => [7, 8, 9],
  };
}

void differentMapLiterals() {
  final value = 1;

  final result = switch (value) {
    1 => {'key': 'value'},
    2 => {'other': 'data'},
    3 => {'another': 'entry'},
  };
}

void differentTernary() {
  final value = 5;

  final result = switch (value) {
    1 => value > 0 ? 'positive' : 'negative',
    2 => value == 0 ? 'zero' : 'nonzero',
    3 => value < 0 ? 'negative' : 'positive',
  };
}

void nestedSwitchExpressions() {
  final x = 1;
  final y = 2;

  final result = switch (x) {
    1 => switch (y) {
        1 => 'one-one',
        _ => 'one-other',
      },
    2 => switch (y) {
        1 => 'two-one',
        _ => 'two-other',
      },
    _ => 'other',
  };
}
