import 'package:flutter/widgets.dart';

void trigger() {
  // expect_lint: avoid_unnecessary_gesture_detector
  GestureDetector(child: Text('Hello'));

  // expect_lint: avoid_unnecessary_gesture_detector
  GestureDetector(child: Text('Hello'), behavior: HitTestBehavior.opaque);
}
