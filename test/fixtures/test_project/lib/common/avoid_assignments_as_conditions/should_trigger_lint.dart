// Test cases that should trigger the avoid-assignments-as-conditions lint

// ignore_for_file: dead_code, unused_local_variable, unnecessary_null_comparison

void test() {
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
    values.last;
  }

  var i = 0;
  do {
    i++;
    // expect_lint: avoid_assignments_as_conditions
  } while (flag = i < 5);

  // expect_lint: avoid_assignments_as_conditions
  final result = (flag = values.isEmpty) ? 'empty' : 'not empty';

  // expect_lint: avoid_assignments_as_conditions
  if ((nullable ??= 'default') != null) {
    print(nullable);
  }
}

void testFor() {
  bool flag = false;
  // expect_lint: avoid_assignments_as_conditions
  for (var i = 0; flag = i < 10; i++) {
    print(i);
  }
}
