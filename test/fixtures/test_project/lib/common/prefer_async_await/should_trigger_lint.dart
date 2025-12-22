// Test cases that should trigger the prefer_async_await lint

Future<String> fetchData() async {
  return 'data';
}

Future<int> calculateValue() async {
  return 42;
}

void example1() {
  // expect_lint: prefer_async_await
  fetchData().then((result) {
    print(result);
  });
}

void example2() {
  // expect_lint: prefer_async_await
  calculateValue().then((value) {
    print(value);
  });
}

void example3() {
  // expect_lint: prefer_async_await
  fetchData().then((result) {
    return result.toUpperCase();
  });
}

void example4() {
  // Chaining then calls - both should trigger
  fetchData()
      // expect_lint: prefer_async_await
      .then((result) {
        return result.length;
      })
      // expect_lint: prefer_async_await
      .then((length) {
        print('Length: $length');
      });
}

class MyClass {
  Future<String> getData() async {
    return 'class data';
  }

  void processData() {
    // expect_lint: prefer_async_await
    getData().then((data) {
      print(data);
    });
  }
}

void example5() {
  final obj = MyClass();
  // expect_lint: prefer_async_await
  obj.getData().then((data) {
    print(data);
  });
}

// Using then with error handler
void example6() {
  // expect_lint: prefer_async_await
  fetchData().then(
    (result) {
      print(result);
    },
    onError: (error) {
      print('Error: $error');
    },
  );
}

// Using then in an async function is still discouraged
Future<void> example7() async {
  // expect_lint: prefer_async_await
  fetchData().then((result) {
    print(result);
  });
}
