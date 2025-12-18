// This file should NOT trigger the avoid_cascade_after_if_null lint

class Cow {
  void moo() {}
}

void fn() {
  Cow? nullableCow;

  // Parentheses around the entire null-coalescing expression
  // ignore: unused_local_variable
  final cow1 = (nullableCow ?? Cow())..moo();

  // Cascade only applied to the new instance
  // ignore: unused_local_variable
  final cow2 = nullableCow ?? (Cow()..moo());

  // No cascade at all
  // ignore: unused_local_variable
  final cow3 = nullableCow ?? Cow();
}
