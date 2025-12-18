// This file should trigger the avoid_casting_to_extension_type lint

extension type const ET(String s) {}
extension type const ET1(int v) {}

void fn(String input) {
  // expect_lint: avoid_casting_to_extension_type
  // ignore: unused_local_variable
  final value1 = input as ET;

  // expect_lint: avoid_casting_to_extension_type
  // ignore: unused_local_variable
  final value2 = input as ET1;
}
