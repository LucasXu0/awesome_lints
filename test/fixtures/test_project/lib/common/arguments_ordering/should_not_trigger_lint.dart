// Test cases that should NOT trigger the arguments-ordering lint

class Person {
  Person({required String name, String? surname, int? age});
}

void buildPerson({required String name, String? surname, int? age}) {}

void test() {
  // Correct order - matches declaration
  // ignore: unused_local_variable
  final person1 = Person(name: 'Winnie', surname: 'Pooh', age: 42);

  buildPerson(name: 'Winnie', surname: 'Pooh', age: 42);

  // Partial arguments in correct order
  buildPerson(name: 'Winnie', age: 42);

  // Single named argument
  buildPerson(name: 'Winnie');

  // Positional arguments (not checked)
  void positionalFn(String a, String b) {}
  positionalFn('a', 'b');
}
