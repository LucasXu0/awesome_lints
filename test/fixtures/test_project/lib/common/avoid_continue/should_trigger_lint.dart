final _values = [1, 2, 3, 4, 5];

void badExamples() {
  for (final value in _values) {
    if (value == 1) {
      // expect_lint: avoid_continue
      continue;
    }
    print(value);
  }

  for (var i = 0; i < 10; i++) {
    if (i % 2 == 0) {
      // expect_lint: avoid_continue
      continue;
    }
    print('Odd: $i');
  }

  var count = 0;
  while (count < 10) {
    count++;
    if (count == 5) {
      // expect_lint: avoid_continue
      continue;
    }
    print(count);
  }
}
