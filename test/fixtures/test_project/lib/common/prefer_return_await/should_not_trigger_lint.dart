// Test cases that should NOT trigger the prefer-return-await lint

Future<String> anotherAsyncMethod() async {
  return 'result';
}

// Good: Using await
Future<String> goodReport(Iterable<String> records) async {
  try {
    return await anotherAsyncMethod();
  } catch (e) {
    print(e);
    rethrow;
  }
}

// Good: Returning from finally (not try)
Future<int> goodFinally(int value) async {
  try {
    print('trying');
  } finally {
    return Future.value(value);
  }
}

// Good: Not in a try block
Future<String> goodNoTry() async {
  return anotherAsyncMethod();
}

// Good: Not async function
Future<String> syncFunction() {
  try {
    return anotherAsyncMethod();
  } catch (e) {
    rethrow;
  }
}

// Good: Returning non-Future value
Future<String> goodReturnValue() async {
  try {
    return 'value';
  } catch (e) {
    rethrow;
  }
}

class MyService {
  Future<String> fetchData() async {
    return 'data';
  }

  // Good: Using await
  Future<String> goodProcess() async {
    try {
      return await fetchData();
    } catch (e) {
      return 'error';
    }
  }
}
