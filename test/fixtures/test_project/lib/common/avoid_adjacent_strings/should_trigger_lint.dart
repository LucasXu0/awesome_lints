// Test cases that should trigger the avoid-adjacent-strings lint

void test() {
  // expect_lint: avoid_adjacent_strings
  final str1 = 'hello' 'world'; // ignore: unused_local_variable

  // expect_lint: avoid_adjacent_strings
  final str2 = 'foo' 'bar' 'baz'; // ignore: unused_local_variable

  // expect_lint: avoid_adjacent_strings
  someFn('hello' 'world');

  // expect_lint: avoid_adjacent_strings
  final str3 = 'multi' // ignore: unused_local_variable
      'line'
      'string';
}

void someFn(String str) {
  print(str);
}
