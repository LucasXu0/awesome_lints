// Test cases that should NOT trigger the avoid-assignments-as-conditions lint

void test() {
  bool flag = false;
  final values = <int>[];
  String? nullable;

  // Assignment before condition
  flag = values.isEmpty;
  if (flag) {
    print('empty');
  }

  // Comparison (not assignment)
  if (flag == true) {
    print('true');
  }

  // Null-aware assignment before loop
  nullable ??= 'default';
  // ignore: unnecessary_null_comparison
  while (nullable != null) {
    break;
  }

  // Ternary with comparison
  // ignore: unused_local_variable
  final result = flag ? 'true' : 'false';

  // Compound assignment operators are OK (e.g., +=, -=)
  var counter = 0;
  counter += 5;
  if (counter > 0) {
    print(counter);
  }
}

void testFor() {
  // ignore: unused_local_variable
  var sum = 0;
  for (var i = 0; i < 10; i++) {
    sum += i;
  }
}
