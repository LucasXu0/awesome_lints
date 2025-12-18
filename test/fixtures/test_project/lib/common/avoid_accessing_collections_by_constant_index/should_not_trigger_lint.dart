// Test cases that should NOT trigger the avoid-accessing-collections-by-constant-index lint

void test() {
  final list = [1, 2, 3, 4, 5];

  // Using loop variable as index
  for (var i = 0; i < list.length; i++) {
    print(list[i]);
  }

  // Accessing outside loop
  print(list[0]);
  print(list[2]);

  // Using mutable variable
  var index = 0;
  for (var i = 0; i < 5; i++) {
    print(list[index]);
    index++;
  }

  // For-each loop
  for (var item in list) {
    print(item);
  }
}
