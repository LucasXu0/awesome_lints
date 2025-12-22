// This file should NOT trigger the avoid_bottom_type_in_patterns lint

void fn(Object? object) {
  // Using null checks is correct
  if (object == null) {}

  if (object case == null) {}

  final value = switch (object) {
    == null => 'good',
    _ => 'good',
  };

  // Using regular types is fine
  if (object case String()) {}
}
