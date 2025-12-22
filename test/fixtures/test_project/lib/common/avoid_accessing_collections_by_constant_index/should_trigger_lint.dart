// Test cases that should trigger the avoid-accessing-collections-by-constant-index lint

void test() {
  final list = [1, 2, 3, 4, 5];
  const int constantIndex = 2;
  final int finalIndex = 1;

  for (var i = 0; i < 10; i++) {
    // expect_lint: avoid_accessing_collections_by_constant_index
    print(list[0]);

    // expect_lint: avoid_accessing_collections_by_constant_index
    print(list[constantIndex]);

    // expect_lint: avoid_accessing_collections_by_constant_index
    print(list[finalIndex]);
  }

  // ignore: unused_local_variable
  for (var item in list) {
    // expect_lint: avoid_accessing_collections_by_constant_index
    print(list[2]);
  }

  var j = 0;
  while (j < 5) {
    // expect_lint: avoid_accessing_collections_by_constant_index
    print(list[3]);
    j++;
  }
}

class MyClass {
  static final int staticIndex = 0;
}

void testStaticFinal() {
  final list = [1, 2, 3];

  for (var i = 0; i < 3; i++) {
    // expect_lint: avoid_accessing_collections_by_constant_index
    print(list[MyClass.staticIndex]);
  }
}
