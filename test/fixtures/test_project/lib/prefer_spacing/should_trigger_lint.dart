import 'package:flutter/widgets.dart';

// ignore_for_file: unused_local_variable, prefer_const_constructors

class ShouldTriggerLint extends StatelessWidget {
  const ShouldTriggerLint({super.key});

  @override
  Widget build(BuildContext context) {
    // Case 1: Column with SizedBox for height spacing - should trigger
    // expect_lint: prefer_spacing
    final widget1 = Column(
      children: [
        Text('First'),
        SizedBox(height: 10),
        Text('Second'),
      ],
    );

    // Case 2: Row with SizedBox for width spacing - should trigger
    // expect_lint: prefer_spacing
    final widget2 = Row(
      children: [
        Text('Left'),
        SizedBox(width: 20),
        Text('Right'),
      ],
    );

    // Case 3: Column with multiple SizedBox spacers - should trigger
    // expect_lint: prefer_spacing
    final widget3 = Column(
      children: [
        Text('One'),
        SizedBox(height: 8),
        Text('Two'),
        SizedBox(height: 8),
        Text('Three'),
      ],
    );

    // Case 4: Flex with SizedBox spacing - should trigger
    // expect_lint: prefer_spacing
    final widget4 = Flex(
      direction: Axis.vertical,
      children: [
        Text('Item 1'),
        SizedBox(height: 16),
        Text('Item 2'),
      ],
    );

    // Case 5: Row with const SizedBox - should trigger
    // expect_lint: prefer_spacing
    final widget5 = Row(
      children: [
        Icon(Icons.star),
        const SizedBox(width: 8),
        Text('Rating'),
      ],
    );

    return Container();
  }
}
