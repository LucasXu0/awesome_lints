// Test cases that should NOT trigger the prefer_early_return lint

// Valid: If statement with else clause
void processItem(String? item) {
  if (item != null) {
    print('Processing: $item');
  } else {
    print('No item to process');
  }
}

// Valid: Multiple statements in function body
void validateInput(int value) {
  print('Validating...');
  if (value > 0) {
    print('Valid value');
  }
}

// Valid: Already using early return pattern
void checkValue(String? value) {
  if (value == null) {
    return;
  }
  print('Processing: $value');
}

// Valid: If statement is not the only statement
void handleData(List<int> data) {
  final count = data.length;
  if (count > 0) {
    print('Has $count items');
  }
  print('Done');
}

// Valid: Multiple if statements
void multipleChecks(int a, int b) {
  if (a > 0) {
    print('a is positive');
  }
  if (b > 0) {
    print('b is positive');
  }
}

// Valid: Empty function
void emptyFunction() {}

// Valid: Function with only return statement
int getValue() {
  return 42;
}

// Valid: Function with if-else chain
void checkStatus(int status) {
  if (status == 0) {
    print('Pending');
  } else if (status == 1) {
    print('Active');
  } else {
    print('Done');
  }
}

// Valid: Function with switch statement
void handleEvent(String event) {
  switch (event) {
    case 'start':
      print('Starting');
      break;
    case 'stop':
      print('Stopping');
      break;
  }
}

// Valid: Function with try-catch
void riskyOperation() {
  try {
    print('Attempting operation');
  } catch (e) {
    print('Error: $e');
  }
}

// Valid: Function with for loop
void printNumbers(int count) {
  for (var i = 0; i < count; i++) {
    print(i);
  }
}

// Valid: Function with while loop
void countdown(int n) {
  while (n > 0) {
    print(n);
    n--;
  }
}

// Valid: Expression-bodied function
int double(int x) => x * 2;

// Valid: Function with variable declaration and usage
void processData(String data) {
  final trimmed = data.trim();
  print('Processed: $trimmed');
}

// Valid: Function with multiple early returns
String? findItem(List<String> items, String target) {
  if (items.isEmpty) {
    return null;
  }

  if (!items.contains(target)) {
    return null;
  }

  return target;
}

// Valid: Nested if with outer code
void validateRange(int value) {
  print('Checking range...');
  if (value >= 0) {
    if (value <= 100) {
      print('In range');
    }
  }
  print('Check complete');
}

// Valid: If statement with else-if
void categorize(int score) {
  if (score >= 90) {
    print('A');
  } else if (score >= 80) {
    print('B');
  }
}

// Valid: Function that returns void with statements after if
void notify(bool shouldNotify) {
  if (shouldNotify) {
    print('Notification sent');
  }
  print('Function completed');
}

// Valid: Class with constructor (not a regular function body)
class Example {
  Example() {
    print('Constructor called');
  }
}

// Valid: Getter that doesn't wrap entire body in if
class DataHolder {
  String? _data;

  String get data {
    return _data ?? 'default';
  }
}

// Valid: Setter with multiple statements
class Config {
  String _value = '';

  set value(String newValue) {
    _value = newValue;
    print('Value updated');
  }
}
