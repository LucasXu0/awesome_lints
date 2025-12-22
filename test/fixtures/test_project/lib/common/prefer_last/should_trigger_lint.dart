// Test cases that should trigger the prefer-last lint

void testIndexAccess() {
  final list = [1, 2, 3, 4, 5];

  // expect_lint: prefer_last
  print(list[list.length - 1]);

  final names = ['Alice', 'Bob', 'Charlie'];
  // expect_lint: prefer_last
  final lastUser = names[names.length - 1];
  print(lastUser);
}

void testElementAtAccess() {
  final numbers = [10, 20, 30];

  // expect_lint: prefer_last
  print(numbers.elementAt(numbers.length - 1));

  final items = ['a', 'b', 'c'];
  // expect_lint: prefer_last
  final lastItem = items.elementAt(items.length - 1);
  print(lastItem);
}

void testWithDifferentCollectionTypes() {
  final set = {1, 2, 3};
  // expect_lint: prefer_last
  print(set.elementAt(set.length - 1));

  final iterable = Iterable.generate(5);
  // expect_lint: prefer_last
  print(iterable.elementAt(iterable.length - 1));
}
