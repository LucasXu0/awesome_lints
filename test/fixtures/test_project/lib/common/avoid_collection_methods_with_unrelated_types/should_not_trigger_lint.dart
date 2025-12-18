// Test cases that should NOT trigger the avoid_collection_methods_with_unrelated_types lint

void test() {
  final List<int> intList = [1, 2, 3];
  final Set<String> stringSet = {'a', 'b', 'c'};
  final Map<int, String> intStringMap = {1: 'one', 2: 'two'};
  final List<String> stringList = ['a', 'b', 'c'];
  final List<num> numList = [1, 2.5, 3];

  // Valid: List<int>.contains with int argument
  final contains1 = intList.contains(1);

  // Valid: List<int>.indexOf with int argument
  final index2 = intList.indexOf(2);

  // Valid: List<int>.indexOf with int argument
  final index1 = intList.indexOf(3);

  // Valid: Set<String>.contains with String argument
  final contains2 = stringSet.contains('a');

  // Valid: Set<String>.lookup with String argument
  final lookup1 = stringSet.lookup('b');

  // Valid: Map<int, String>.containsKey with int argument
  final hasKey = intStringMap.containsKey(1);

  // Valid: Map<int, String>.containsValue with String argument
  final hasValue = intStringMap.containsValue('one');

  // Valid: Map<int, String>.containsKey with int key
  final hasKey2 = intStringMap.containsKey(2);

  // Valid: Map index access with correct key type
  final value = intStringMap[1];

  // Valid: List index access with int
  final item = stringList[0];

  // Valid: List<String>.lastIndexOf with String argument
  final lastIndex = stringList.lastIndexOf('c');

  // Valid: Subtype compatibility - int is subtype of num
  final numContains = numList.contains(1);
  final numIndex = numList.indexOf(2.5);

  // Valid: Dynamic collections (no type checking)
  final dynamicList = <dynamic>[1, 'two', true];
  dynamicList.contains('anything');
  final dynIndex = dynamicList.indexOf(123);

  // Valid: Object type (accepts anything)
  final objectList = <Object>[1, 'two', true];
  objectList.contains('test');

  // Valid: Nullable types
  final nullableIntList = <int?>[1, 2, null];
  nullableIntList.contains(null);

  // Valid: Methods that don't check element type
  final length = intList.length;
  final isEmpty = stringSet.isEmpty;
  final keys = intStringMap.keys;

  print(
      '$contains1 $contains2 $index1 $index2 $hasKey $hasValue $hasKey2 $value $item $lastIndex $numContains $numIndex $lookup1 $dynIndex $length $isEmpty $keys');
}
