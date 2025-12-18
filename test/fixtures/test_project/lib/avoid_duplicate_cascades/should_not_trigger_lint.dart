class Value {
  String? field;
  String? another;
}

void goodExamples() {
  // Different fields, no duplication
  final value = Value()
    ..field = '2'
    ..another = '1';

  // Different indexes, no duplication
  final list = [1, 2, 3]
    ..[1] = 2
    ..[2] = 3;

  // Each field set only once
  final obj = Value()
    ..field = 'value'
    ..another = 'other';

  print(value);
  print(list);
  print(obj);
}
