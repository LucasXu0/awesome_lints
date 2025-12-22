// Test cases that should trigger the prefer_iterable_of lint

void test() {
  final List<int> intList = [1, 2, 3];
  final Set<String> stringSet = {'a', 'b', 'c'};
  final List<String> stringList = ['x', 'y', 'z'];
  final Set<int> intSet = {10, 20, 30};

  // Case 1: List<int>.from(List<int>) - same types
  // expect_lint: prefer_iterable_of
  final list1 = List<int>.from(intList);

  // Case 2: List<String>.from(List<String>) - same types
  // expect_lint: prefer_iterable_of
  final list2 = List<String>.from(stringList);

  // Case 3: Set<String>.from(Set<String>) - same types
  // expect_lint: prefer_iterable_of
  final set1 = Set<String>.from(stringSet);

  // Case 4: Set<int>.from(Set<int>) - same types
  // expect_lint: prefer_iterable_of
  final set2 = Set<int>.from(intSet);

  // Case 5: List<int>.from(Set<int>) - compatible types
  // expect_lint: prefer_iterable_of
  final list3 = List<int>.from(intSet);

  // Case 6: Set<String>.from(List<String>) - compatible types
  // expect_lint: prefer_iterable_of
  final set3 = Set<String>.from(stringList);

  print('$list1 $list2 $set1 $set2 $list3 $set3');
}
