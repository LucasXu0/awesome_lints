// This file should trigger the avoid_cascade_after_if_null lint

class Cow {
  void moo() {}
}

void fn() {
  Cow? nullableCow;

  // expect_lint: avoid_cascade_after_if_null
  final cow = nullableCow ?? Cow()
    ..moo();
}
