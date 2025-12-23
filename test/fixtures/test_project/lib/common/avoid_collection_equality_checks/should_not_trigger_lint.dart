// Test cases that should NOT trigger the avoid_collection_equality_checks lint

void test() {
  final list1 = [1, 2, 3];
  final list2 = [1, 2, 3];

  // Valid: Comparing const collections (compile-time constants)
  if (const [1, 2, 3] == const [1, 2, 3]) {
    print('equal');
  }

  // Valid: Comparing const sets
  if (const {1, 2, 3} == const {1, 2, 3}) {
    print('equal');
  }

  // Valid: Comparing const maps
  if (const {'a': 1} == const {'a': 1}) {
    print('equal');
  }

  // Valid: Comparing non-collection types
  final int a = 5;
  final int b = 5;
  if (a == b) {
    print('equal');
  }

  // Valid: Comparing strings
  final str1 = 'hello';
  final str2 = 'hello';
  if (str1 == str2) {
    print('equal');
  }

  // Valid: Comparing booleans
  final bool1 = true;
  final bool2 = false;
  if (bool1 == bool2) {
    print('equal');
  }

  // Valid: Comparing collection lengths (not the collections themselves)
  if (list1.length == list2.length) {
    print('same length');
  }

  // Valid: Comparing individual elements
  if (list1[0] == list2[0]) {
    print('first elements equal');
  }

  // Valid: Using isEmpty check
  if (list1.isEmpty) {
    print('empty');
  }

  // Valid: Comparing with identity operator (intentional reference check)
  if (identical(list1, list2)) {
    print('same reference');
  }

  // Valid: Object equality
  final obj1 = Object();
  final obj2 = Object();
  if (obj1 == obj2) {
    print('equal');
  }

  // Valid: Null checks on collections
  final List<int>? nullableList = null;
  if (nullableList == null) {
    print('list is null');
  }

  if (nullableList != null) {
    print('list is not null');
  }

  // Valid: Null checks on maps
  final Map<String, int>? nullableMap = null;
  if (nullableMap == null) {
    print('map is null');
  }

  if (null == nullableMap) {
    print('map is null (reversed)');
  }

  // Valid: Null checks on sets
  final Set<String>? nullableSet = null;
  if (nullableSet != null) {
    print('set is not null');
  }
}
