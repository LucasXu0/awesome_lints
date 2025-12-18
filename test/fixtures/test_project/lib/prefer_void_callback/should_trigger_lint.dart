// ignore_for_file: unused_local_variable, unused_element

/// Test cases where prefer_void_callback lint should trigger

// Case 1: Function parameter with void Function()
void functionWithCallback(
  // expect_lint: prefer_void_callback
  void Function() callback,
) {
  callback();
}

// Case 2: Variable declaration with void Function()
void variableDeclarations() {
  // expect_lint: prefer_void_callback
  final void Function() callback = () {};
  // expect_lint: prefer_void_callback
  void Function()? nullableCallback;
}

// Case 3: Return type as void Function()
// expect_lint: prefer_void_callback
void Function() returnCallback() {
  return () {};
}

// Case 4: Generic type argument with void Function()
void genericTypes() {
  final List<
      // expect_lint: prefer_void_callback
      void Function()> callbacks = [];
  final Map<String,
      // expect_lint: prefer_void_callback
      void Function()> callbackMap = {};
}

// Case 5: Class field with void Function()
class MyClass {
  // expect_lint: prefer_void_callback
  final void Function()? onPressed;
  // expect_lint: prefer_void_callback
  void Function() callback = () {};

  MyClass(this.onPressed);
}

// Case 6: Typedef with void Function()
// expect_lint: prefer_void_callback
typedef CallbackAlias = void Function();

// Case 7: Constructor parameter with void Function()
class MyWidget {
  final
  // expect_lint: prefer_void_callback
  void Function()? onTap;

  const MyWidget({this.onTap});
}

// Case 8: Optional parameter with void Function()
void optionalParameters([
  // expect_lint: prefer_void_callback
  void Function()? callback,
]) {
  callback?.call();
}

// Case 9: Named parameter with void Function()
void namedParameters({
  // expect_lint: prefer_void_callback
  void Function()? onComplete,
}) {
  onComplete?.call();
}