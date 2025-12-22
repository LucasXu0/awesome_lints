import 'package:fake_async/fake_async.dart';

void main() {
  // expect_lint: avoid_async_callback_in_fake_async
  FakeAsync().run((fakeAsync) async {
    await Future.delayed(Duration(seconds: 1));
  });

  // expect_lint: avoid_async_callback_in_fake_async
  FakeAsync().run((async) async {
    // Variable named 'async' but callback is async
    await Future.value(42);
  });

  // expect_lint: avoid_async_callback_in_fake_async
  FakeAsync().run((fa) async {
    await Future.microtask(() {
      // Some async operation
    });
  });
}
