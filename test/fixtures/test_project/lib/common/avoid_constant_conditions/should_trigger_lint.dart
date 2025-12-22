const _another = 10;

abstract final class Some {
  static const _val = '1';
}

void badExamples() {
  // expect_lint: avoid_constant_conditions
  if (_another == 11) {
    print('This will never execute');
  }

  // expect_lint: avoid_constant_conditions
  if (Some._val == '1') {
    print('This always executes');
  } else {
    print('This never executes');
  }

  // expect_lint: avoid_constant_conditions
  while (_another == 10) {
    print('Infinite loop');
    break;
  }

  const x = 5;
  const y = 10;

  // expect_lint: avoid_constant_conditions
  final result = x < y ? 'less' : 'greater';

  // Note: Assert statements with constant conditions are handled by
  // the avoid_constant_assert_conditions lint rule, not this one.
  assert(_another == 10);
}
