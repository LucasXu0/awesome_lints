// Test cases that should trigger the avoid_collection_equality_checks lint

void test() {
  final list1 = [1, 2, 3];
  final list2 = [1, 2, 3];
  final set1 = {1, 2, 3};
  final set2 = {1, 2, 3};
  final map1 = {'a': 1, 'b': 2};
  final map2 = {'a': 1, 'b': 2};

  // Case 1: List equality check with ==
  // expect_lint: avoid_collection_equality_checks
  if (list1 == list2) {
    print('equal');
  }

  // Case 2: List inequality check with !=
  // expect_lint: avoid_collection_equality_checks
  if (list1 != list2) {
    print('not equal');
  }

  // Case 3: Set equality check
  // expect_lint: avoid_collection_equality_checks
  if (set1 == set2) {
    print('equal');
  }

  // Case 4: Set inequality check
  // expect_lint: avoid_collection_equality_checks
  if (set1 != set2) {
    print('not equal');
  }

  // Case 5: Map equality check
  // expect_lint: avoid_collection_equality_checks
  if (map1 == map2) {
    print('equal');
  }

  // Case 6: Map inequality check
  // expect_lint: avoid_collection_equality_checks
  if (map1 != map2) {
    print('not equal');
  }

  // Case 7: Inline list creation in comparison
  // expect_lint: avoid_collection_equality_checks
  if ([1, 2, 3] == list1) {
    print('equal');
  }

  // Case 8: Comparing empty lists
  final emptyList1 = [];
  final emptyList2 = [];
  // expect_lint: avoid_collection_equality_checks
  if (emptyList1 == emptyList2) {
    print('equal');
  }

  // Case 9: Comparing sets with inline creation
  // expect_lint: avoid_collection_equality_checks
  if ({1, 2} == set1) {
    print('equal');
  }

  // Case 10: Comparing maps with inline creation
  // expect_lint: avoid_collection_equality_checks
  if ({'key': 'value'} == map1) {
    print('equal');
  }
}
