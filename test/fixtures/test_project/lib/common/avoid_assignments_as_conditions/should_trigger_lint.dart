// Test cases that should trigger the avoid-assignments-as-conditions lint

void test() {
  // ignore: unused_local_variable
  bool flag = false;
  final values = <int>[];
  String? nullable;

  // expect_lint: avoid_assignments_as_conditions
  if (flag = values.isEmpty) {
    print('empty');
  }

  // expect_lint: avoid_assignments_as_conditions
  if (flag = true) {
    print('true');
  }

  // expect_lint: avoid_assignments_as_conditions
  while (flag = values.isNotEmpty) {
    values.removeLast();
  }

  var i = 0;
  // expect_lint: avoid_assignments_as_conditions
  do {
    i++;
  } while (flag = i < 5);

  // expect_lint: avoid_assignments_as_conditions
  // ignore: unused_local_variable
  final result = (flag = values.isEmpty) ? 'empty' : 'not empty';

  // expect_lint: avoid_assignments_as_conditions
  // ignore: unnecessary_null_comparison
  if ((nullable ??= 'default') != null) {
    print(nullable);
  }
}

void testFor() {
  // ignore: unused_local_variable
  bool flag = false;
  // expect_lint: avoid_assignments_as_conditions
  for (var i = 0; flag = i < 10; i++) {
    print(i);
  }
}
