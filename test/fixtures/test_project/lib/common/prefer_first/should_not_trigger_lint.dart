// Test cases that should NOT trigger the prefer-first lint

void testAlreadyUsingFirst() {
  final list = [1, 2, 3, 4, 5];

  // Using .first is the correct approach
  print(list.first);

  final names = ['Alice', 'Bob', 'Charlie'];
  final firstUser = names.first;
  print(firstUser);
}

void testNonZeroIndex() {
  final list = [1, 2, 3, 4, 5];

  // Accessing other indices is fine
  print(list[1]);
  print(list[2]);
  print(list[list.length - 1]);

  // Using elementAt with non-zero index
  print(list.elementAt(1));
  print(list.elementAt(3));
}

void testVariableIndex() {
  final list = [1, 2, 3, 4, 5];
  var index = 0;

  // Using a variable index is fine
  print(list[index]);
  print(list.elementAt(index));
}

void testInLoop() {
  final list = [1, 2, 3, 4, 5];

  for (var i = 0; i < list.length; i++) {
    // Using loop variable as index is fine
    print(list[i]);
  }
}
