import 'package:flutter/widgets.dart';

// ignore_for_file: unused_local_variable, prefer_const_constructors

class ShouldTriggerLint extends StatelessWidget {
  const ShouldTriggerLint({super.key});

  @override
  Widget build(BuildContext context) {
    // Case 1: SizedBox with identical height and width (height first) - should trigger
    final widget1 =
        // expect_lint: prefer_sized_box_square
        SizedBox(
      height: 10,
      width: 10,
    );

    // Case 2: SizedBox with identical height and width (width first) - should trigger
    final widget2 =
        // expect_lint: prefer_sized_box_square
        SizedBox(
      width: 20,
      height: 20,
    );

    return Container();
  }
}
