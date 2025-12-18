// Test cases that should trigger the avoid_collection_methods_with_unrelated_types lint

void test() {
  final List<int> intList = [1, 2, 3];
  final Set<String> stringSet = {'a', 'b', 'c'};
  final Map<int, String> intStringMap = {1: 'one', 2: 'two'};

  // Case 1: List<int>.contains with String argument
  // expect_lint: avoid_collection_methods_with_unrelated_types
  final contains1 = intList.contains('not an int');

  // Case 2: List<int>.indexOf with String argument
  // expect_lint: avoid_collection_methods_with_unrelated_types
  final index1 = intList.indexOf('not an int');

  // Case 4: Set<String>.contains with int argument
  // expect_lint: avoid_collection_methods_with_unrelated_types
  final contains2 = stringSet.contains(42);

  // Case 5: Set<String>.contains with bool argument
  // expect_lint: avoid_collection_methods_with_unrelated_types
  final contains3 = stringSet.contains(true);

  // Case 6: Map<int, String>.containsKey with String argument
  // expect_lint: avoid_collection_methods_with_unrelated_types
  final hasKey = intStringMap.containsKey('not an int');

  // Case 7: Map<int, String>.containsValue with int argument
  // expect_lint: avoid_collection_methods_with_unrelated_types
  final hasValue = intStringMap.containsValue(123);

  // Case 8: Map<int, String>.containsKey with String key
  // expect_lint: avoid_collection_methods_with_unrelated_types
  final hasKey2 = intStringMap.containsKey('not an int');

  // Case 9: Map index access with wrong key type
  // expect_lint: avoid_collection_methods_with_unrelated_types
  final value = intStringMap['wrong type'];

  print(
      '$contains1 $index1 $contains2 $contains3 $hasKey $hasValue $hasKey2 $value');
}
