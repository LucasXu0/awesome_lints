// Test cases that should trigger the prefer-return-await lint

Future<String> anotherAsyncMethod() async {
  return 'result';
}

Future<String> badReport(Iterable<String> records) async {
  try {
    // expect_lint: prefer_return_await
    return anotherAsyncMethod();
  } catch (e) {
    print(e);
    rethrow;
  }
}

Future<int> badCalculate(int value) async {
  try {
    // expect_lint: prefer_return_await
    return Future.value(value * 2);
  } on Exception {
    return 0;
  }
}

class MyService {
  Future<String> fetchData() async {
    return 'data';
  }

  Future<String> badProcess() async {
    try {
      // expect_lint: prefer_return_await
      return fetchData();
    } catch (e) {
      return 'error';
    }
  }
}
