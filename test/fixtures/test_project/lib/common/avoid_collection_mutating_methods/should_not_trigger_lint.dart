// Test cases that should NOT trigger the avoid_collection_mutating_methods lint

void test() {
  final list = [1, 2, 3];
  final set = {1, 2, 3};
  final map = {'a': 1, 'b': 2};

  // Valid: Non-mutating List methods
  final length = list.length;
  final first = list.first;
  final last = list.last;
  final isEmpty = list.isEmpty;
  final isNotEmpty = list.isNotEmpty;
  final contains = list.contains(1);
  final indexOf = list.indexOf(2);
  final sublist = list.sublist(0, 2);
  final reversed = list.reversed;
  final joined = list.join(',');

  // Valid: Non-mutating Set methods
  final setLength = set.length;
  final setFirst = set.first;
  final setLast = set.last;
  final setContains = set.contains(1);
  final union = set.union({4, 5});
  final intersection = set.intersection({2, 3});
  final difference = set.difference({1});

  // Valid: Non-mutating Map methods
  final mapLength = map.length;
  final mapIsEmpty = map.isEmpty;
  final mapKeys = map.keys;
  final mapValues = map.values;
  final mapEntries = map.entries;
  final mapContainsKey = map.containsKey('a');
  final mapContainsValue = map.containsValue(1);

  // Valid: Transforming methods that return new collections
  final mapped = list.map((e) => e * 2);
  final filtered = list.where((e) => e > 1);
  final expanded = list.expand((e) => [e, e]);
  final folded = list.fold(0, (sum, e) => sum + e);
  final reduced = list.reduce((a, b) => a + b);

  // Valid: forEach (doesn't mutate collection itself)
  list.forEach(print);

  // Valid: any, every, firstWhere
  final any = list.any((e) => e > 2);
  final every = list.every((e) => e > 0);
  final firstWhere = list.firstWhere((e) => e > 1);

  // Valid: Creating new collections
  final newList = [...list];
  final newSet = {...set};
  final newMap = {...map};

  // Valid: Using toList, toSet (creates new collections)
  final asList = set.toList();
  final asSet = list.toSet();

  print(
      '$length $first $last $isEmpty $isNotEmpty $contains $indexOf $sublist $reversed $joined');
  print(
      '$setLength $setFirst $setLast $setContains $union $intersection $difference');
  print(
      '$mapLength $mapIsEmpty $mapKeys $mapValues $mapEntries $mapContainsKey $mapContainsValue');
  print('$mapped $filtered $expanded $folded $reduced');
  print('$any $every $firstWhere');
  print('$newList $newSet $newMap');
  print('$asList $asSet');
}
