import 'package:flutter/material.dart';

// ignore_for_file: unused_local_variable, prefer_const_constructors, prefer_sized_box_square

class ShouldNotTriggerLint extends StatelessWidget {
  const ShouldNotTriggerLint({super.key});

  @override
  Widget build(BuildContext context) {
    // Case 1: Column with spacing parameter already used - should NOT trigger
    final widget1 = Column(
      spacing: 10,
      children: [
        Text('First'),
        Text('Second'),
      ],
    );

    // Case 2: Row with spacing parameter already used - should NOT trigger
    final widget2 = Row(
      spacing: 8,
      children: [
        Text('Left'),
        Text('Right'),
      ],
    );

    // Case 3: SizedBox with child (not for spacing) - should NOT trigger
    final widget3 = Column(
      children: [
        Text('Top'),
        SizedBox(
          height: 100,
          child: Container(color: Colors.red),
        ),
        Text('Bottom'),
      ],
    );

    // Case 4: SizedBox with both width and height - should NOT trigger
    final widget4 = Row(
      children: [
        Text('Left'),
        SizedBox(width: 50, height: 50),
        Text('Right'),
      ],
    );

    // Case 5: Column without any SizedBox - should NOT trigger
    final widget5 = Column(
      children: [
        Text('One'),
        Text('Two'),
        Text('Three'),
      ],
    );

    // Case 6: Column with SizedBox that has wrong dimension - should NOT trigger
    // (width in Column is not typically for spacing)
    final widget6 = Column(
      children: [
        Text('Item'),
        SizedBox(width: 100),
        Text('Another'),
      ],
    );

    // Case 7: Row with SizedBox that has wrong dimension - should NOT trigger
    // (height in Row is not typically for spacing)
    final widget7 = Row(
      children: [
        Text('Item'),
        SizedBox(height: 100),
        Text('Another'),
      ],
    );

    return Container();
  }
}
