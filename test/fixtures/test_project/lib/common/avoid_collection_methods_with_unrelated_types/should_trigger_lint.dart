// Test cases that should trigger the avoid_collection_methods_with_unrelated_types lint

void test() {
  final List<int> intList = [1, 2, 3];
  final Set<String> stringSet = {'a', 'b', 'c'};
  final Map<int, String> intStringMap = {1: 'one', 2: 'two'};
  final List<String> stringList = ['a', 'b', 'c'];

  // Case 1: List<int>.contains with String argument
  // expect_lint: avoid_collection_methods_with_unrelated_types
  final contains1 = intList.contains('not an int');

  // Case 2: List<int>.remove with String argument
  // expect_lint: avoid_collection_methods_with_unrelated_types
  intList.remove('not an int');

  // Case 3: List<int>.indexOf with double argument
  // expect_lint: avoid_collection_methods_with_unrelated_types
  final index1 = intList.indexOf(3.14);

  // Case 4: Set<String>.contains with int argument
  // expect_lint: avoid_collection_methods_with_unrelated_types
  final contains2 = stringSet.contains(42);

  // Case 5: Set<String>.remove with bool argument
  // expect_lint: avoid_collection_methods_with_unrelated_types
  stringSet.remove(true);

  // Case 6: Map<int, String>.containsKey with String argument
  // expect_lint: avoid_collection_methods_with_unrelated_types
  final hasKey = intStringMap.containsKey('not an int');

  // Case 7: Map<int, String>.containsValue with int argument
  // expect_lint: avoid_collection_methods_with_unrelated_types
  final hasValue = intStringMap.containsValue(123);

  // Case 8: Map<int, String>.remove with String key
  // expect_lint: avoid_collection_methods_with_unrelated_types
  intStringMap.remove('not an int');

  // Case 9: Map index access with wrong key type
  // expect_lint: avoid_collection_methods_with_unrelated_types
  final value = intStringMap['wrong type'];

  // Case 10: List index access with String (should be int)
  // expect_lint: avoid_collection_methods_with_unrelated_types
  final item = stringList['not an index'];

  // Case 11: List<String>.lastIndexOf with int argument
  // expect_lint: avoid_collection_methods_with_unrelated_types
  final lastIndex = stringList.lastIndexOf(42);

  print(
      '$contains1 $contains2 $index1 $hasKey $hasValue $value $item $lastIndex');
}
