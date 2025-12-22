import 'package:flutter/foundation.dart';

/// Test cases where prefer_void_callback lint should NOT trigger

// Case 1: Using VoidCallback typedef (correct usage)
void functionWithVoidCallback(VoidCallback callback) {
  callback();
}

// Case 2: Variable with VoidCallback
void variableWithVoidCallback() {
  final VoidCallback callback = () {};
  VoidCallback? nullableCallback;
}

// Case 3: Return type as VoidCallback
VoidCallback returnVoidCallback() {
  return () {};
}

// Case 4: Generic type with VoidCallback
void genericTypesWithVoidCallback() {
  final List<VoidCallback> callbacks = [];
  final Map<String, VoidCallback> callbackMap = {};
}

// Case 5: Class field with VoidCallback
class MyClass {
  final VoidCallback? onPressed;
  VoidCallback callback = () {};

  MyClass(this.onPressed);
}

// Case 6: void Function with parameters (should NOT trigger)
void functionWithParameters(void Function(int) callback) {
  callback(42);
}

// Case 7: void Function with multiple parameters (should NOT trigger)
void functionWithMultipleParameters(void Function(String, int) callback) {
  callback('hello', 42);
}

// Case 8: Function returning non-void (should NOT trigger)
void functionReturningValue(int Function() callback) {
  callback();
}

// Case 9: Optional parameters with VoidCallback
void optionalParametersWithVoidCallback([VoidCallback? callback]) {
  callback?.call();
}

// Case 10: Named parameters with VoidCallback
void namedParametersWithVoidCallback({VoidCallback? onComplete}) {
  onComplete?.call();
}

// Case 11: Generic function with parameters (should NOT trigger)
void genericWithParameters() {
  final List<void Function(int)> callbacks = [];
}

// Case 12: Function with named parameters (should NOT trigger)
void functionWithNamedParams(void Function({String? name}) callback) {
  callback(name: 'test');
}
