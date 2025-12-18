// Test cases that should trigger dispose_class_fields lint
// ignore_for_file: dead_code, unused_local_variable, deaded_code, unused_field

import 'dart:async';

class SomeDisposable {
  void dispose() {}
}

class SomeCloseable {
  void close() {}
}

class SomeCancellable {
  void cancel() {}
}

class TestClass1 {
  final _disposable = SomeDisposable();

  // expect_lint: dispose_class_fields
  final _anotherDisposable = SomeDisposable();

  void dispose() {
    _disposable.dispose();
    // Missing: _anotherDisposable.dispose()
  }
}

class TestClass2 {
  // expect_lint: dispose_class_fields
  final _closeable = SomeCloseable();

  void close() {
    // Missing: _closeable.close()
  }
}

class TestClass3 {
  final _streamController = StreamController<int>();
  // expect_lint: dispose_class_fields
  final _anotherController = StreamController<String>();

  void dispose() {
    _streamController.close();
    // Missing: _anotherController.close()
  }
}
