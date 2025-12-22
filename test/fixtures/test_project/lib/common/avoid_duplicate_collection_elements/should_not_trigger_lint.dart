final list = [1, 2, 3];
final otherList = [4, 5, 6];

void goodExamples() {
  // Single spread, single conditional
  final anotherList = [...list, if (list.isNotEmpty) 'value'];

  // No duplicate literals
  final uniqueLiterals = [1, 2, 3, 4];

  // No duplicate strings
  final uniqueStrings = ['hello', 'world', 'goodbye'];

  // Different spreads
  final combinedList = [...list, ...otherList];

  print(anotherList);
  print(uniqueLiterals);
  print(uniqueStrings);
  print(combinedList);
}
