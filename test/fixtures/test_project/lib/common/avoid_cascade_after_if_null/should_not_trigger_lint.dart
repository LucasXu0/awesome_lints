// This file should NOT trigger the avoid_cascade_after_if_null lint

class Cow {
  void moo() {}
}

void fn() {
  Cow? nullableCow;

  // Parentheses around the entire null-coalescing expression

  final cow1 = (nullableCow ?? Cow())..moo();

  // Cascade only applied to the new instance

  final cow2 = nullableCow ?? (Cow()..moo());

  // No cascade at all

  final cow3 = nullableCow ?? Cow();
}
