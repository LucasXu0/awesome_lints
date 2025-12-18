// Test cases that should NOT trigger the avoid-accessing-other-classes-private-members lint

class SomeClass {
  final String _privateField = 'private';
  final String publicField = 'public';
  String _privateMethod() => 'private method';
  String publicMethod() => 'public method';

  void test() {
    // Accessing own private members is OK
    print(_privateField);
    print(_privateMethod());
  }

  void anotherMethod() {
    // Accessing private members within the same class is OK
    print(_privateField);
  }
}

class OtherClass {
  final String _ownPrivate = 'own';

  void test(SomeClass other) {
    // Accessing public members is OK
    print(other.publicField);
    print(other.publicMethod());

    // Accessing own private members is OK
    print(_ownPrivate);
  }
}
