import 'package:flutter/widgets.dart';

// ignore_for_file: unused_local_variable, prefer_const_constructors

class ShouldNotTriggerLint extends StatelessWidget {
  const ShouldNotTriggerLint({super.key});

  @override
  Widget build(BuildContext context) {
    // Case 1: SizedBox.square - should NOT trigger (already using square)
    final widget1 = SizedBox.square(
      dimension: 10,
    );

    // Case 2: SizedBox with different height and width - should NOT trigger
    final widget2 = SizedBox(
      width: 20,
      height: 10,
    );

    // Case 3: SizedBox with only height - should NOT trigger
    final widget3 = SizedBox(
      height: 10,
    );

    // Case 4: SizedBox with only width - should NOT trigger
    final widget4 = SizedBox(
      width: 20,
    );

    // Case 5: SizedBox with no dimensions - should NOT trigger
    final widget5 = SizedBox(
      child: Text('Hello'),
    );

    return Container();
  }
}
