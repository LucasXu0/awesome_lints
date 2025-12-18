void badExamples(int anotherNum) {
  // expect_lint: avoid_contradictory_expressions
  if (anotherNum == 3 && anotherNum == 4) {
    print('impossible');
  }

  // expect_lint: avoid_contradictory_expressions
  if (anotherNum < 4 && anotherNum > 4) {
    print('impossible');
  }

  // expect_lint: avoid_contradictory_expressions
  if (anotherNum == 2 && anotherNum != 2) {
    print('impossible');
  }

  final x = 5;
  // expect_lint: avoid_contradictory_expressions
  if (x == 5 && x == 6) {
    print('impossible');
  }
}
