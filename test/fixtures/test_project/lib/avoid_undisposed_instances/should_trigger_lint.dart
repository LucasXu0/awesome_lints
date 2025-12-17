import 'package:flutter/widgets.dart';

class DisposableClass {
  void dispose() {}
}

void trigger() {
  // expect_lint: avoid_undisposed_instances
  DisposableClass();

  // expect_lint: avoid_undisposed_instances
  TextSpan(text: 'Hello', recognizer: DisposableClass() as dynamic);
}