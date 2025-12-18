// ignore_for_file: dead_code, unused_local_variable

class Test {
  String? field;
  Test? object;
  int? number;

  void method() {
    // Basic non-null assertion on property access
    // expect_lint: avoid_non_null_assertion
    field!.contains('other');

    // Chained non-null assertions
    // expect_lint: avoid_non_null_assertion
    object!.field!.contains('other');

    // Non-null assertion on method invocation
    // expect_lint: avoid_non_null_assertion
    object!.method();

    // Non-null assertion on property
    // expect_lint: avoid_non_null_assertion
    final value = field!;

    // Non-null assertion in expression
    // expect_lint: avoid_non_null_assertion
    final length = field!.length;

    // Non-null assertion with arithmetic
    // expect_lint: avoid_non_null_assertion
    final result = number! + 5;

    // Non-null assertion in condition
    // expect_lint: avoid_non_null_assertion
    if (field!.isEmpty) {
      print('empty');
    }

    // Non-null assertion in list
    final list = <String?>[null, 'hello'];
    // expect_lint: avoid_non_null_assertion
    final item = list[0]!;

    // Multiple assertions in one line
    // expect_lint: avoid_non_null_assertion
    final nested = object!.object!.field;
  }

  String? getValue() => null;

  void testMethodCall() {
    // Non-null assertion on method return
    // expect_lint: avoid_non_null_assertion
    getValue()!.contains('test');
  }
}

// Non-null assertion on function parameter
void processString(String? input) {
  // expect_lint: avoid_non_null_assertion
  print(input!.toUpperCase());
}

// Non-null assertion in field initializer
class MyClass {
  String? nullable;

  // expect_lint: avoid_non_null_assertion
  late String value = nullable!;
}

// Map index operations with non-null assertion
void mapOperations() {
  final map = <String, String>{'a': 'alpha', 'b': 'beta'};

  // expect_lint: avoid_non_null_assertion
  final value1 = map['a']!;

  // expect_lint: avoid_non_null_assertion
  final value2 = map['b']!.toUpperCase();

  // Nested maps
  final nestedMap = <String, Map<String, String>>{
    'outer': {'inner': 'value'}
  };

  // expect_lint: avoid_non_null_assertion
  final innerValue = nestedMap['outer']!['inner']!;
}
