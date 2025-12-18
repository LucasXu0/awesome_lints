// This file should NOT trigger the avoid_casting_to_extension_type lint

extension type const ET(String s) {}

void fn(String input) {
  // Direct instantiation instead of casting
  // ignore: unused_local_variable
  final value = ET(input);

  // Casting to regular types is fine
  dynamic x = 'test';
  // ignore: unused_local_variable
  final str = x as String;
}
