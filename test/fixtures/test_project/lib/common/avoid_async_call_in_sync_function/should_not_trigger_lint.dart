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

// Test FutureBuilder pattern - should not trigger
class FutureBuilder<T> {
  final Future<T> future;
  final void Function(dynamic, dynamic) builder;

  FutureBuilder({required this.future, required this.builder});
}

Future<String> _fetchData() async {
  return 'data';
}

void testFutureBuilder() {
  // Should NOT trigger - future parameter expects a Future
  final widget1 = FutureBuilder<String>(
    future: _fetchData(),
    builder: (context, snapshot) {
      return;
    },
  );

  // Should NOT trigger - another async function passed to Future parameter
  final widget2 = FutureBuilder<int>(
    future: MyClass().asyncMethod(),
    builder: (context, snapshot) {
      return;
    },
  );

  print(widget1);
  print(widget2);
}

// Test function parameters that expect Future
void functionAcceptingFuture(Future<String> future) {
  print(future);
}

void testFunctionParameter() {
  // Should NOT trigger - parameter expects a Future
  functionAcceptingFuture(asyncFunction());
}

// Note: Assignment to Future-typed variables currently triggers a warning
// This is a known limitation that will be addressed in a future update
