final list = [1, 2, 3];

void badExamples() {
  final anotherList = [
    ...list,
    // expect_lint: avoid_duplicate_collection_elements
    ...list,
    if (list.isNotEmpty) 'value',
    // expect_lint: avoid_duplicate_collection_elements
    if (list.isNotEmpty) 'value',
  ];

  final duplicateLiterals = [
    1,
    2,
    // expect_lint: avoid_duplicate_collection_elements
    1,
    3,
  ];

  final duplicateStrings = [
    'hello',
    'world',
    // expect_lint: avoid_duplicate_collection_elements
    'hello',
  ];

  final duplicateSet = {
    'a',
    'b',
    // ignore_for_file: equal_elements_in_set
    // expect_lint: avoid_duplicate_collection_elements
    'a',
  };

  print(anotherList);
  print(duplicateLiterals);
  print(duplicateStrings);
  print(duplicateSet);
}
