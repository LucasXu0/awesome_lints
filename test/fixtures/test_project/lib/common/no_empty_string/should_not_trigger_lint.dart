class Test {
  // Non-empty strings in variable assignment
  void testVariables() {
    var value = 'hello';
    String message = 'world';
    final greeting = 'Hi there';
  }

  // Non-empty strings in function calls
  void testFunctionCalls() {
    print('Hello, World!');
    Uri.https('example.com');
  }

  // Non-empty strings in method calls
  void testMethodCalls() {
    var list = <String>[];
    list.add('item');

    var map = <String, String>{};
    map['key'] = 'value';
  }

  // Proper empty check using isEmpty
  void testComparisons(String input) {
    if (input.isEmpty) {
      print('empty');
    }

    if (input.isNotEmpty) {
      print('not empty');
    }

    var isEmpty = input.isEmpty;
  }

  // Non-empty strings in ternary
  void testTernary(bool condition) {
    var result = condition ? 'yes' : 'no';
    var result2 = condition ? 'value1' : 'value2';
  }

  // Non-empty strings in collections
  void testCollections() {
    var list = ['hello', 'world'];
    var map = {'key': 'value'};
    var set = {'hello', 'world'};
  }

  // Non-empty string in return
  String testReturn(bool condition) {
    if (condition) {
      return 'success';
    }

    return 'failure';
  }

  // Non-empty field initializer
  String field = 'default value';
  final String finalField = 'constant';

  // Non-empty default parameter
  Test({String name = 'default'});

  void withDefault([String value = 'default']) {
    print(value);
  }

  void withNamed({String value = 'default'}) {
    print(value);
  }

  // Proper string concatenation
  void testConcatenation() {
    var firstName = 'John';
    var lastName = 'Doe';
    var fullName = firstName + ' ' + lastName;
    var greeting = firstName + 'Hello, ';
  }

  // Using isEmpty in assert
  void testAssert() {
    var value = 'test';
    assert(value.isNotEmpty);
  }

  // Non-empty case in switch
  void testSwitch(String value) {
    switch (value) {
      case 'option1':
        print('first option');
        break;

      case 'option2':
        print('second option');
        break;

      default:
        print('default');
    }
  }
}

// Top-level constants with values
const appName = 'My App';
const version = '1.0.0';

// Top-level variables with values
var userName = 'John';
var userEmail = 'john@example.com';

// Function returning non-empty string
String getMessage() {
  return 'Hello, World!';
}

// Expression body with value
String getGreeting() => 'Hi there!';

// Null coalescing with non-empty default
void testNullCoalescing(String? value) {
  var result = value ?? 'default value';
}

// String interpolation without empty strings
void testInterpolation() {
  var name = 'John';
  var age = 30;
  var message = 'Name: $name, Age: $age';
  var greeting = 'Hello, $name!';
}

// Using const for empty string when it's a valid use case
class Config {
  static const String emptyPlaceholder = 'A';

  void useConstant(String input) {
    // Using a named constant is acceptable
    if (input == Config.emptyPlaceholder) {
      print('matches empty placeholder');
    }
  }
}

// Multi-line strings
void multilineStrings() {
  var text = '''
This is a multi-line
string with content.
''';

  var code = '''
void function() {
  print('hello');
}
''';
}

// Raw strings
void rawStrings() {
  var pattern = r'\d+';
  var path = r'C:\Users\Documents';
}
