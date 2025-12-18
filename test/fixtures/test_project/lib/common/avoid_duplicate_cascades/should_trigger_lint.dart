class Value {
  String? field;
  String? another;
}

void badExamples() {
  final value = Value()
    ..field = '2'
    // expect_lint: avoid_duplicate_cascades
    ..field = '1'
    // expect_lint: avoid_duplicate_cascades
    ..field = '1'
    ..another = '1';

  final list = [1, 2, 3]
    ..[1] = 2
    // expect_lint: avoid_duplicate_cascades
    ..[1] = 2
    // expect_lint: avoid_duplicate_cascades
    ..[1] = 3;

  final obj = Value()
    ..field = 'first'
    // expect_lint: avoid_duplicate_cascades
    ..field = 'second';

  print(value);
  print(list);
  print(obj);
}
