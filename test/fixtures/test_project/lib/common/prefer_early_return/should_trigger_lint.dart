// Test cases that should trigger the prefer_early_return lint

// Case 1: Simple function with entire body wrapped in if
void processItem(String? item) {
  // expect_lint: prefer_early_return
  if (item != null) {
    print('Processing: $item');
  }
}

// Case 2: Function with complex condition
void validateInput(int value) {
  // expect_lint: prefer_early_return
  if (value > 0 && value < 100) {
    print('Valid value: $value');
  }
}

// Case 3: Function with multiple statements in if body
void handleData(List<int> data) {
  // expect_lint: prefer_early_return
  if (data.isNotEmpty) {
    final first = data.first;
    final last = data.last;
    print('First: $first, Last: $last');
  }
}

// Case 4: Async function
Future<void> fetchData(String? url) async {
  // expect_lint: prefer_early_return
  if (url != null) {
    await Future.delayed(Duration(seconds: 1));
    print('Fetched from: $url');
  }
}

// Case 5: Method in a class
class DataProcessor {
  void process(String? data) {
    // expect_lint: prefer_early_return
    if (data != null) {
      print('Processing data: $data');
    }
  }
}

// Case 6: Function returning a value - this is actually good pattern
// (not the "entire body wrapped" pattern that prefer_early_return targets)
int calculate(int? input) {
  if (input != null) {
    return input * 2;
  }
  return 0;
}

// Case 7: Function with negated condition
void checkStatus(bool isReady) {
  // expect_lint: prefer_early_return
  if (!isReady) {
    print('Not ready yet');
  }
}

// Case 8: Function with compound condition
void validateUser(String? name, int? age) {
  // expect_lint: prefer_early_return
  if (name != null && age != null && age > 18) {
    print('Valid user: $name, age $age');
  }
}

// Case 9: Lambda/closure
void testClosure() {
  final handler = (String? value) {
    // expect_lint: prefer_early_return
    if (value != null) {
      print('Handling: $value');
    }
  };
  handler('test');
}

// Case 10: Getter with body wrapped in if
class ConfigManager {
  bool _isEnabled = false;

  void updateConfig(bool value) {
    // expect_lint: prefer_early_return
    if (value != _isEnabled) {
      _isEnabled = value;
      print('Config updated');
    }
  }
}

// Case 11: Function with list check
void printItems(List<String>? items) {
  // expect_lint: prefer_early_return
  if (items != null && items.isNotEmpty) {
    for (final item in items) {
      print(item);
    }
  }
}

// Case 12: Function with equality check
void compareValues(int a, int b) {
  // expect_lint: prefer_early_return
  if (a == b) {
    print('Values are equal');
  }
}
