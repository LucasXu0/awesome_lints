// ignore_for_file: dead_code, unused_local_variable, unchecked_use_of_nullable_value

class Test {
  String? field;
  Test? object;
  int? number;
  String nonNullable = 'hello';

  void method() {
    // Using null-aware operator
    field?.contains('other');

    // Using null-aware with cascade
    object?.field?.contains('other');

    // Using null coalescing operator
    final value = field ?? 'default';

    // Proper null check
    if (field != null) {
      field.contains('other');
    }

    // Using non-nullable type (no assertion needed)
    nonNullable.contains('test');

    // Null check with local variable
    final localField = field;
    if (localField != null) {
      localField.contains('test');
    }

    // Map index operation with ! (explicitly allowed by DCM)
    final map = {'key': 'value'};
    map['key']!.contains('other');

    // Nested map access with !
    final nested = {
      'outer': {'inner': 'value'}
    };
    nested['outer']!['inner']!.toUpperCase();

    // Null-aware method call
    object?.method();

    // If-null operator in expression
    final length = field?.length ?? 0;

    // Conditional expression with null check
    final result = number != null ? number + 5 : 0;
  }

  String? getValue() => null;

  void testMethodCall() {
    // Null-aware on method return
    getValue()?.contains('test');

    // Using if-null on method return
    final value = getValue() ?? 'default';
  }
}

// Proper null handling in function
void processString(String? input) {
  if (input != null) {
    print(input.toUpperCase());
  }
}

// Using null-aware in function
void processStringNullAware(String? input) {
  input?.toUpperCase();
}

// Non-nullable parameter (no assertion needed)
void processNonNullable(String input) {
  print(input.toUpperCase());
}

// Map operations (allowed)
void mapOperations() {
  final map = <String, String>{'a': 'alpha', 'b': 'beta'};

  // These are allowed per DCM documentation
  final value1 = map['a']!;
  final value2 = map['b']!.toUpperCase();

  // Nested maps
  final nestedMap = <String, Map<String, String>>{
    'outer': {'inner': 'value'}
  };
  final innerValue = nestedMap['outer']!['inner']!;
}

// Using is check with smart cast
void smartCast(Object? obj) {
  if (obj is String) {
    // No need for ! because of smart cast
    obj.contains('test');
  }
}
