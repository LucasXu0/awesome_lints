// Test cases that should NOT trigger the prefer-last lint

void testAlreadyUsingLast() {
  final list = [1, 2, 3, 4, 5];

  // Using .last is the correct approach
  print(list.last);

  final names = ['Alice', 'Bob', 'Charlie'];
  final lastUser = names.last;
  print(lastUser);
}

void testNonLastIndex() {
  final list = [1, 2, 3, 4, 5];

  // Accessing other indices is fine
  print(list[0]);
  print(list[1]);
  print(list[2]);

  // Using elementAt with other indices
  print(list.elementAt(0));
  print(list.elementAt(2));
}

void testDifferentExpressions() {
  final list = [1, 2, 3, 4, 5];

  // Different arithmetic expressions are fine
  print(list[list.length - 2]); // Second to last
  print(list[list.length - 3]); // Third to last
  print(list[list.length ~/ 2]); // Middle element

  // Using elementAt with other expressions
  print(list.elementAt(list.length ~/ 2));
}

void testVariableIndex() {
  final list = [1, 2, 3, 4, 5];
  var index = list.length - 1;

  // Using a variable index is fine
  print(list[index]);
  print(list.elementAt(index));
}
