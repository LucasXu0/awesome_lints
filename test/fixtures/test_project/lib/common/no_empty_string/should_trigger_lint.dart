// ignore_for_file: dead_code, unused_local_variable

class Test {
  // Empty string in variable assignment
  void testVariables() {
    // expect_lint: no_empty_string
    var empty = '';

    // expect_lint: no_empty_string
    String emptyString = '';

    // expect_lint: no_empty_string
    final value = '';
  }

  // Empty string in function call
  void testFunctionCalls() {
    // expect_lint: no_empty_string
    print('');

    // expect_lint: no_empty_string
    Uri.https('');
  }

  // Empty string in method call
  void testMethodCalls() {
    var list = <String>[];
    // expect_lint: no_empty_string
    list.add('');

    var map = <String, String>{};
    // expect_lint: no_empty_string
    map['key'] = '';
  }

  // Empty string in comparison
  void testComparisons(String input) {
    // expect_lint: no_empty_string
    if (input == '') {
      print('empty');
    }

    // expect_lint: no_empty_string
    if (input != '') {
      print('not empty');
    }

    // expect_lint: no_empty_string
    var isEmpty = input == '';
  }

  // Empty string in ternary
  void testTernary(bool condition) {
    // expect_lint: no_empty_string
    var result = condition ? '' : 'value';

    // expect_lint: no_empty_string
    var result2 = condition ? 'value' : '';
  }

  // Empty string in list
  void testCollections() {
    // expect_lint: no_empty_string
    var list = ['hello', ''];

    // expect_lint: no_empty_string
    var map = {'key': ''};

    // expect_lint: no_empty_string
    var set = {'hello', ''};
  }

  // Empty string in return
  String testReturn(bool condition) {
    if (condition) {
      // expect_lint: no_empty_string
      return '';
    }
    
return 'value';
  }

  // Empty string in field initializer
  // expect_lint: no_empty_string
  String field = '';

  // expect_lint: no_empty_string
  final String finalField = '';

  // Empty string in constructor
  // expect_lint: no_empty_string
  Test({String name = ''});

  // Empty string in default parameter
  // expect_lint: no_empty_string
  void withDefault([String value = '']) {
    print(value);
  }

  // Empty string in named parameter
  // expect_lint: no_empty_string
  void withNamed({String value = ''}) {
    print(value);
  }

  // Empty string in string concatenation
  void testConcatenation() {
    var name = 'John';
    // expect_lint: no_empty_string
    var result = name + '';

    // expect_lint: no_empty_string
    var result2 = name + '';
  }

  // Empty string in assert
  void testAssert() {
    var value = 'test';
    // expect_lint: no_empty_string
    assert(value != '');
  }

  // Empty string in switch
  void testSwitch(String value) {
    switch (value) {
      // expect_lint: no_empty_string
      case '':
        print('empty');
        break;
      
case 'other':
        print('other');
        break;
    }
  }
}

// Top-level constant with empty string
// expect_lint: no_empty_string
const emptyConst = '';

// Top-level variable with empty string
// expect_lint: no_empty_string
var emptyVar = '';

// Function returning empty string
String getEmpty() {
  // expect_lint: no_empty_string
  return '';
}

// Empty string in expression body
// expect_lint: no_empty_string
String getEmptyExpression() => '';

// Empty string in null coalescing
void testNullCoalescing(String? value) {
  // expect_lint: no_empty_string
  var result = value ?? '';
}

// Empty string in string interpolation
void testInterpolation() {
  var name = 'John';
  // expect_lint: no_empty_string
  var result = '$name${''}';
}
