import 'package:flutter/foundation.dart';

// ignore_for_file: unused_local_variable, unused_element

/// Test cases where prefer_async_callback lint should NOT trigger

// Case 1: Using AsyncCallback typedef (correct usage)
void functionWithAsyncCallback(AsyncCallback callback) {
  callback();
}

// Case 2: Variable with AsyncCallback
void variableWithAsyncCallback() {
  final AsyncCallback callback = () async {};
  AsyncCallback? nullableCallback;
}

// Case 3: Return type as AsyncCallback
AsyncCallback returnAsyncCallback() {
  return () async {};
}

// Case 4: Generic type with AsyncCallback
void genericTypesWithAsyncCallback() {
  final List<AsyncCallback> callbacks = [];
  final Map<String, AsyncCallback> callbackMap = {};
}

// Case 5: Class field with AsyncCallback
class MyClass {
  final AsyncCallback? onPressed;
  AsyncCallback callback = () async {};

  MyClass(this.onPressed);
}

// Case 6: Future<void> Function with parameters (should NOT trigger)
void functionWithParameters(Future<void> Function(int) callback) {
  callback(42);
}

// Case 7: Future<void> Function with multiple parameters (should NOT trigger)
void functionWithMultipleParameters(
    Future<void> Function(String, int) callback) {
  callback('hello', 42);
}

// Case 8: Function returning non-void Future (should NOT trigger)
void functionReturningValue(Future<int> Function() callback) {
  callback();
}

// Case 9: Optional parameters with AsyncCallback
void optionalParametersWithAsyncCallback([AsyncCallback? callback]) {
  callback?.call();
}

// Case 10: Named parameters with AsyncCallback
void namedParametersWithAsyncCallback({AsyncCallback? onComplete}) {
  onComplete?.call();
}

// Case 11: Generic function with parameters (should NOT trigger)
void genericWithParameters() {
  final List<Future<void> Function(int)> callbacks = [];
}

// Case 12: Function with named parameters (should NOT trigger)
void functionWithNamedParams(Future<void> Function({String? name}) callback) {
  callback(name: 'test');
}

// Case 13: Synchronous void Function() (should NOT trigger)
// ignore: prefer_void_callback
void synchronousCallback(void Function() callback) {
  callback();
}

// Case 14: Future without type argument (should NOT trigger)
void futureWithoutTypeArg(Future Function() callback) {
  callback();
}

// Case 15: Future<String> (should NOT trigger)
void futureString(Future<String> Function() callback) {
  callback();
}
