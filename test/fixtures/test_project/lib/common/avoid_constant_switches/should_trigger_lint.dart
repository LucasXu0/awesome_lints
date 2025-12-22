const _another = 10;

abstract final class Some {
  static const _val = '1';
}

void badExamples() {
  // expect_lint: avoid_constant_switches
  final value = switch (Some._val) {
    '1' => 'one',
    '2' => 'two',
    _ => 'other',
  };

  // expect_lint: avoid_constant_switches
  switch (_another) {
    case 10:
      print('ten');
      break;

    case 20:
      print('twenty');
      break;

    default:
      print('other');
  }

  const constValue = 'test';
  // expect_lint: avoid_constant_switches
  switch (constValue) {
    case 'test':
      print('matched');
      break;
  }
}
