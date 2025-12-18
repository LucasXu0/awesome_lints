void goodExamples(String value, int number) {
  // Using variables instead of constants
  if (value == '1') {
    print('hello');
  } else {
    print('hi');
  }

  if (number == 10) {
    print('ten');
  }

  while (number > 0) {
    print(number);
    number--;
  }

  final result = number < 5 ? 'less' : 'greater';

  assert(value.isNotEmpty);
}
