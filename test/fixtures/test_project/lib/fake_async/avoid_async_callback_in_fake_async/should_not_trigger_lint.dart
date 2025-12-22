import 'package:fake_async/fake_async.dart';

void main() {
  // Good: synchronous callback
  FakeAsync().run((fakeAsync) {
    fakeAsync.elapse(Duration(seconds: 1));
  });

  // Good: synchronous callback with explicit return
  FakeAsync().run((fakeAsync) {
    return;
  });

  // Good: synchronous callback with statement
  FakeAsync().run((fakeAsync) {
    fakeAsync.flushMicrotasks();
  });

  // Good: synchronous callback with multiple statements
  FakeAsync().run((fakeAsync) {
    fakeAsync.elapse(Duration(seconds: 1));
    fakeAsync.flushMicrotasks();
    fakeAsync.elapse(Duration(milliseconds: 500));
  });
}
