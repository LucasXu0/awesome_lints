// Test cases that should NOT trigger the avoid-async-call-in-sync-function lint

import 'dart:async';

Future<String> asyncFunction() async {
  return 'result';
}

class MyClass {
  Future<int> asyncMethod() async {
    return 42;
  }

  Future<void> asyncWrapper() async {
    // Awaited in async context
    await asyncFunction();
    await asyncMethod();
  }

  void syncMethodWithUnawaited() {
    // Explicitly marked as unawaited
    unawaited(asyncFunction());
    unawaited(asyncMethod());
  }

  void syncMethodWithIgnore() {
    // Using .ignore() extension
    asyncFunction().ignore();
    asyncMethod().ignore();
  }
}

Future<void> asyncTopLevel() async {
  await asyncFunction();
}

void syncWithCallback() {
  // Callback is async
  Future.delayed(Duration(seconds: 1), () async {
    await asyncFunction();
  });
}
