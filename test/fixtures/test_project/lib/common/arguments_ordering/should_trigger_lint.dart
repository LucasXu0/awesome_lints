// Test cases that should trigger the arguments-ordering lint

class Person {
  Person({required String name, required String surname, required int age});
}

void buildPerson({
  required String name,
  required String surname,
  required int age,
}) {}

void test() {
  // expect_lint: arguments_ordering
  final person1 = Person(age: 42, surname: 'Pooh', name: 'Winnie');

  // expect_lint: arguments_ordering
  buildPerson(surname: 'Pooh', age: 42, name: 'Winnie');

  // expect_lint: arguments_ordering
  buildPerson(age: 42, name: 'Winnie', surname: 'Pooh');
}

class Widget {
  Widget({
    required String child,
    required double width,
    required double height,
  });
}

void createWidget() {
  // expect_lint: arguments_ordering
  final widget = Widget(height: 100, child: 'Test', width: 200);
}
