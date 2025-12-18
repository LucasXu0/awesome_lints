// Test cases that should NOT trigger dispose_class_fields lint
// ignore_for_file: dead_code, unused_local_variable, deaded_code, unused_field

import 'dart:async';

class SomeDisposable {
  void dispose() {}
}

class SomeCloseable {
  void close() {}
}

class TestClass1 {
  final _disposable = SomeDisposable();
  final _anotherDisposable = SomeDisposable();

  void dispose() {
    _disposable.dispose();
    _anotherDisposable.dispose();
  }
}

class TestClass2 {
  final _closeable = SomeCloseable();

  void close() {
    _closeable.close();
  }
}

class TestClass3 {
  final _streamController = StreamController<int>();
  final _anotherController = StreamController<String>();

  void dispose() {
    _streamController.close();
    _anotherController.close();
  }
}

class TestClass4 {
  // No cleanup method - should not trigger
  final _disposable = SomeDisposable();
}

class TestClass5 {
  // No disposable fields
  final _value = 42;

  void dispose() {
    // Nothing to dispose
  }
}
