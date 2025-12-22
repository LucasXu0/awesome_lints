// Test cases that should NOT trigger the prefer_async_await lint

Future<String> fetchData() async {
  return 'data';
}

Future<int> calculateValue() async {
  return 42;
}

// Using async/await - the recommended approach
Future<void> example1() async {
  final result = await fetchData();
  print(result);
}

Future<void> example2() async {
  final value = await calculateValue();
  print(value);
}

// Using async/await with error handling
Future<void> example3() async {
  try {
    final result = await fetchData();
    print(result);
  } catch (error) {
    print('Error: $error');
  }
}

// Chaining with async/await
Future<void> example4() async {
  final result = await fetchData();
  final length = result.length;
  print('Length: $length');
}

class MyClass {
  Future<String> getData() async {
    return 'class data';
  }

  Future<void> processData() async {
    final data = await getData();
    print(data);
  }
}

Future<void> example5() async {
  final obj = MyClass();
  final data = await obj.getData();
  print(data);
}

// Non-Future then method should not trigger
class CustomClass {
  CustomClass then(void Function(int) callback) {
    callback(42);
    return this;
  }
}

void example6() {
  final custom = CustomClass();
  // Should NOT trigger - not a Future
  custom.then((value) {
    print(value);
  });
}

// Using await in an expression
Future<void> example7() async {
  print(await fetchData());
}

// Multiple awaits
Future<void> example8() async {
  final result1 = await fetchData();
  final result2 = await calculateValue();
  print('$result1, $result2');
}

// Await in a loop
Future<void> example9() async {
  for (var i = 0; i < 3; i++) {
    final result = await fetchData();
    print(result);
  }
}

// Returning a Future directly (not awaited, but not using then)
Future<String> example10() {
  return fetchData();
}

// Using Future.wait
Future<void> example11() async {
  final results = await Future.wait([fetchData(), fetchData()]);
  print(results);
}
