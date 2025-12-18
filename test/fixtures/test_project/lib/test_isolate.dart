import 'dart:isolate';

void test() async {
  // expect_lint: prefer_compute_over_isolate_run
  await Isolate.run(() => 42);
}
