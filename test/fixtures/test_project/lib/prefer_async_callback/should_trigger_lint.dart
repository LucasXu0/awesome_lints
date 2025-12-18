// ignore_for_file: unused_local_variable, unused_element

/// Test cases where prefer_async_callback lint should trigger

// Case 1: Function parameter with Future<void> Function()
void functionWithCallback(
  // expect_lint: prefer_async_callback
  Future<void> Function() callback,
) {
  callback();
}

// Case 2: Variable declaration with Future<void> Function()
void variableDeclarations() {
  // expect_lint: prefer_async_callback
  final Future<void> Function() callback = () async {};
  // expect_lint: prefer_async_callback
  Future<void> Function()? nullableCallback;
}

// Case 3: Return type as Future<void> Function()
// expect_lint: prefer_async_callback
Future<void> Function() returnCallback() {
  return () async {};
}

// Case 4: Generic type argument with Future<void> Function()
void genericTypes() {
  final List<
      // expect_lint: prefer_async_callback
      Future<void> Function()> callbacks = [];
  final Map<
      String,
      // expect_lint: prefer_async_callback
      Future<void> Function()> callbackMap = {};
}

// Case 5: Class field with Future<void> Function()
class MyClass {
  // expect_lint: prefer_async_callback
  final Future<void> Function()? onPressed;
  // expect_lint: prefer_async_callback
  Future<void> Function() callback = () async {};

  MyClass(this.onPressed);
}

// Case 6: Typedef with Future<void> Function()
// expect_lint: prefer_async_callback
typedef CallbackAlias = Future<void> Function();

// Case 7: Constructor parameter with Future<void> Function()
class MyWidget {
  final
      // expect_lint: prefer_async_callback
      Future<void> Function()? onTap;

  const MyWidget({this.onTap});
}

// Case 8: Optional parameter with Future<void> Function()
void optionalParameters([
  // expect_lint: prefer_async_callback
  Future<void> Function()? callback,
]) {
  callback?.call();
}

// Case 9: Named parameter with Future<void> Function()
void namedParameters({
  // expect_lint: prefer_async_callback
  Future<void> Function()? onComplete,
}) {
  onComplete?.call();
}
