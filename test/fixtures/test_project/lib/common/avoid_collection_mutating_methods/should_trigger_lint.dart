// Test cases that should trigger the avoid_collection_mutating_methods lint

void test() {
  final list = [1, 2, 3];
  final set = {1, 2, 3};
  final map = {'a': 1, 'b': 2};

  // Case 1: List add
  // expect_lint: avoid_collection_mutating_methods
  list.add(4);

  // Case 2: List addAll
  // expect_lint: avoid_collection_mutating_methods
  list.addAll([5, 6]);

  // Case 3: List insert
  // expect_lint: avoid_collection_mutating_methods
  list.insert(0, 0);

  // Case 4: List remove
  // expect_lint: avoid_collection_mutating_methods
  list.remove(1);

  // Case 5: List removeAt
  // expect_lint: avoid_collection_mutating_methods
  list.removeAt(0);

  // Case 6: List removeLast
  // expect_lint: avoid_collection_mutating_methods
  list.removeLast();

  // Case 7: List removeRange
  // expect_lint: avoid_collection_mutating_methods
  list.removeRange(0, 2);

  // Case 8: List removeWhere
  // expect_lint: avoid_collection_mutating_methods
  list.removeWhere((e) => e > 2);

  // Case 9: List clear
  // expect_lint: avoid_collection_mutating_methods
  list.clear();

  // Case 10: List sort
  // expect_lint: avoid_collection_mutating_methods
  list.sort();

  // Case 11: List shuffle
  // expect_lint: avoid_collection_mutating_methods
  list.shuffle();

  // Case 12: Set add
  // expect_lint: avoid_collection_mutating_methods
  set.add(4);

  // Case 13: Set addAll
  // expect_lint: avoid_collection_mutating_methods
  set.addAll({5, 6});

  // Case 14: Set remove
  // expect_lint: avoid_collection_mutating_methods
  set.remove(1);

  // Case 15: Set clear
  // expect_lint: avoid_collection_mutating_methods
  set.clear();

  // Case 16: Map putIfAbsent
  // expect_lint: avoid_collection_mutating_methods
  map.putIfAbsent('c', () => 3);

  // Case 17: Map update
  // expect_lint: avoid_collection_mutating_methods
  map.update('a', (value) => value + 1);

  // Case 18: Map updateAll
  // expect_lint: avoid_collection_mutating_methods
  map.updateAll((key, value) => value * 2);

  // Case 19: Map remove
  // expect_lint: avoid_collection_mutating_methods
  map.remove('a');

  // Case 20: Map clear
  // expect_lint: avoid_collection_mutating_methods
  map.clear();
}
