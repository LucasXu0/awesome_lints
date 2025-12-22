import 'package:flutter/widgets.dart';

class ShouldTriggerLint extends StatelessWidget {
  const ShouldTriggerLint({super.key});

  @override
  Widget build(BuildContext context) {
    // Case 1: SizedBox with identical height and width (height first) - should trigger
    final widget1 =
        // expect_lint: prefer_sized_box_square
        SizedBox(width: 10, height: 10);

    // Case 2: SizedBox with identical height and width (width first) - should trigger
    final widget2 =
        // expect_lint: prefer_sized_box_square
        SizedBox(width: 20, height: 20);

    return Container();
  }
}
