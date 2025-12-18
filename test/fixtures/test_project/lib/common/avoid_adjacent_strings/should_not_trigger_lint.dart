// Test cases that should NOT trigger the avoid-adjacent-strings lint

void test() {
  // Single string literal
  // ignore: unused_local_variable
  final str1 = 'hello world';

  // String concatenation with operator
  // ignore: unused_local_variable
  final str2 = 'hello' + ' ' + 'world';

  // String interpolation
  final name = 'World';
  // ignore: unused_local_variable
  final str3 = 'Hello $name';

  // Multiple strings as separate arguments
  someFn('hello', 'world');

  // Multi-line single string
  // ignore: unused_local_variable
  final str4 = '''
    Multi
    line
    string
  ''';
}

void someFn(String str1, String str2) {
  print('$str1 $str2');
}
