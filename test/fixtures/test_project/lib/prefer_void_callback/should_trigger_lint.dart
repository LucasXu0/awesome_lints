// ignore_for_file: unused_local_variable, unused_element

/// Test cases where prefer_void_callback lint should trigger

// Case 1: Function parameter with void Function()
void functionWithCallback(void Function() callback) {
  callback();
}

// Case 2: Variable declaration with void Function()
void variableDeclarations() {
  final void Function() callback = () {};
  void Function()? nullableCallback;
}

// Case 3: Return type as void Function()
void Function() returnCallback() {
  return () {};
}

// Case 4: Generic type argument with void Function()
void genericTypes() {
  final List<void Function()> callbacks = [];
  final Map<String, void Function()> callbackMap = {};
}

// Case 5: Class field with void Function()
class MyClass {
  final void Function()? onPressed;
  void Function() callback = () {};

  MyClass(this.onPressed);
}

// Case 6: Typedef with void Function()
typedef CallbackAlias = void Function();

// Case 7: Constructor parameter with void Function()
class MyWidget {
  final void Function()? onTap;

  const MyWidget({this.onTap});
}

// Case 8: Optional parameter with void Function()
void optionalParameters([void Function()? callback]) {
  callback?.call();
}

// Case 9: Named parameter with void Function()
void namedParameters({void Function()? onComplete}) {
  onComplete?.call();
}
