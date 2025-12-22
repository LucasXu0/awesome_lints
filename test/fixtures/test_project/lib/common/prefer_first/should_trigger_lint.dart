// Test cases that should trigger the prefer-first lint

void testIndexAccess() {
  final list = [1, 2, 3, 4, 5];

  // expect_lint: prefer_first
  print(list[0]);

  final names = ['Alice', 'Bob', 'Charlie'];
  // expect_lint: prefer_first
  final firstUser = names[0];
  print(firstUser);
}

void testElementAtAccess() {
  final numbers = [10, 20, 30];

  // expect_lint: prefer_first
  print(numbers.elementAt(0));

  final items = ['a', 'b', 'c'];
  // expect_lint: prefer_first
  final firstItem = items.elementAt(0);
  print(firstItem);
}

void testWithDifferentCollectionTypes() {
  final set = {1, 2, 3};
  // expect_lint: prefer_first
  print(set.elementAt(0));

  final iterable = Iterable.generate(5);
  // expect_lint: prefer_first
  print(iterable.elementAt(0));
}
