// Test cases that should trigger the avoid-adjacent-strings lint

void test() {
  // expect_lint: avoid_adjacent_strings
  // ignore: unused_local_variable
  final str1 = 'hello' 'world';

  // expect_lint: avoid_adjacent_strings
  // ignore: unused_local_variable
  final str2 = 'foo' 'bar' 'baz';

  // expect_lint: avoid_adjacent_strings
  someFn('hello' 'world');

  // expect_lint: avoid_adjacent_strings
  // ignore: unused_local_variable
  final str3 = 'multi'
      'line'
      'string';
}

void someFn(String str) {
  print(str);
}
