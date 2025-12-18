import 'package:flutter/widgets.dart';

class DisposableClass {
  void dispose() {}
}

void trigger() {
  // expect_lint: avoid_undisposed_instances
  DisposableClass();

  TextSpan(
    text: 'Hello',
    recognizer:
        // expect_lint: avoid_undisposed_instances
        DisposableClass() as dynamic,
  );
}
