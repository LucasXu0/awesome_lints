// Test cases that should trigger the avoid-async-call-in-sync-function lint

Future<String> asyncFunction() async {
  return 'result';
}

class MyClass {
  Future<int> asyncMethod() async {
    return 42;
  }

  void syncMethod() {
    // expect_lint: avoid_async_call_in_sync_function
    asyncFunction();

    // expect_lint: avoid_async_call_in_sync_function
    asyncMethod();
  }
}

void syncFunction() {
  // expect_lint: avoid_async_call_in_sync_function
  asyncFunction();

  final obj = MyClass();
  // expect_lint: avoid_async_call_in_sync_function
  obj.asyncMethod();
}

class Widget {
  Widget() {
    // Constructors can't be async
    // expect_lint: avoid_async_call_in_sync_function
    asyncFunction();
  }
}
