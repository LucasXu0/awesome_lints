// Test cases that should NOT trigger the prefer_iterable_of lint

void test() {
  final List<num> numList = [1, 2.5, 3];
  final List<int> intList = [1, 2, 3];
  final Set<String> stringSet = {'a', 'b', 'c'};
  final List<String> stringList = ['x', 'y', 'z'];

  // Valid: Using .of() instead of .from()
  final list1 = List<int>.of(intList);
  final set1 = Set<String>.of(stringSet);

  // Valid: Type conversion - List<int>.from(List<num>)
  // int is not directly assignable from num, requires conversion
  final list2 = List<int>.from(numList);

  // Valid: Type conversion - List<num>.from(List<int>)
  // Converting to a different type (widening is OK with .from)
  final list3 = List<num>.from(intList);

  // Valid: Dynamic source
  final dynamicList = <dynamic>[1, 'two', true];
  final list4 = List<int>.from(dynamicList);

  // Valid: Using other constructors
  final list5 = List<int>.empty();
  final list6 = List<int>.filled(5, 0);
  final list7 = List<int>.generate(5, (i) => i);
  final set2 = Set<String>.identity();

  // Valid: Map (not List or Set)
  final map1 = Map<int, String>.from({1: 'one', 2: 'two'});

  // Valid: Using .toList() or .toSet()
  final list8 = stringSet.toList();
  final set3 = stringList.toSet();

  // Valid: Spread operator
  final list9 = <int>[...intList];
  final set4 = <String>{...stringSet};

  // Valid: Other methods
  final list10 = List.unmodifiable(intList);

  print(
    '$list1 $list2 $list3 $list4 $list5 $list6 $list7 $list8 $list9 $list10 $set1 $set2 $set3 $set4 $map1',
  );
}
