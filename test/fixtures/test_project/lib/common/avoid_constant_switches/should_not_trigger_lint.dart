void goodExamples(int another, String value) {
  // Using a parameter instead of a constant
  switch (another) {
    case 10:
      print('ten');
      break;
    case 20:
      print('twenty');
      break;
    default:
      print('other');
  }

  final result = switch (value) {
    'one' => 1,
    'two' => 2,
    _ => 0,
  };

  print(result);
}
