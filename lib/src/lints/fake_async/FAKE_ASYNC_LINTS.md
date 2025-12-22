# Fake Async Lint Rules

1 lint rule for the fake_async package to help you write better tests and avoid common pitfalls when testing asynchronous code.

## avoid-async-callback-in-fake-async

Warns when an async callback is passed to `FakeAsync` which is not awaited.

**Why?**

Async callbacks passed to `FakeAsync` are not awaited by the implementation, making tests always pass even when they should fail. This can hide bugs in your asynchronous code and give false confidence in test coverage. The `FakeAsync` utility is designed to work with synchronous callbacks that manually advance time using the provided `FakeAsync` instance.

**Bad:**

```dart
void main() {
  FakeAsync().run((fakeAsync) async {
    // This async callback won't be awaited
    await someAsyncOperation();
    // Assertions here might not run or might run too late
  });

  fakeAsync((fakeAsync) async {
    // Same issue - async callback not awaited
    await anotherAsyncOperation();
  });
}
```

**Good:**

```dart
void main() {
  FakeAsync().run((fakeAsync) {
    // Synchronous callback - properly controlled by FakeAsync
    someAsyncOperation();
    fakeAsync.elapse(Duration(seconds: 1));
    // Assertions run in predictable order
  });

  fakeAsync((fakeAsync) {
    // Synchronous callback
    anotherAsyncOperation();
    fakeAsync.flushMicrotasks();
  });
}
```

---

## Summary

This FakeAsync-specific lint rule helps you:
- Avoid false positives in async tests
- Ensure tests properly validate asynchronous behavior
- Catch test correctness issues at compile time
- Follow FakeAsync best practices

All rules are enabled by default and can be configured in your `analysis_options.yaml` file.
