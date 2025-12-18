// This file should trigger the avoid_bottom_type_in_patterns lint

void fn(Object? object) {
  // expect_lint: avoid_bottom_type_in_patterns
  if (object case Null()) {}

  // expect_lint: avoid_bottom_type_in_patterns
  if (object case Never()) {}

  // ignore: unused_local_variable
  final value = switch (object) {
    // expect_lint: avoid_bottom_type_in_patterns
    Null() => 'bad',
    _ => 'good',
  };
}
