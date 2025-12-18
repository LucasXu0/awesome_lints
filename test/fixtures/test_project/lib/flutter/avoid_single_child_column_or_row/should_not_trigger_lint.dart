import 'package:flutter/material.dart';

// ignore_for_file: unused_local_variable, prefer_const_constructors

class ShouldNotTriggerLint extends StatelessWidget {
  const ShouldNotTriggerLint({super.key});

  @override
  Widget build(BuildContext context) {
    // Case 1: Column with multiple children - should NOT trigger
    final widget1 = Column(
      children: [
        Text('First'),
        Text('Second'),
      ],
    );

    // Case 2: Row with multiple children - should NOT trigger
    final widget2 = Row(
      children: [
        Text('First'),
        Text('Second'),
        Icon(Icons.star),
      ],
    );

    // Case 3: Column with empty children - should NOT trigger
    final widget3 = Column(
      children: [],
    );

    // Case 4: Row with empty children - should NOT trigger
    final widget4 = Row(
      children: [],
    );

    // Case 5: Column with spread operator with multiple items - should NOT trigger
    final items = <Widget>[Text('Item 1'), Text('Item 2')];
    final widget5 = Column(
      children: [...items],
    );

    // Case 6: Column with conditional that adds multiple children - should NOT trigger
    final widget6 = Column(
      children: [
        Text('Always shown'),
        if (true) Text('Conditional'),
      ],
    );

    // Case 7: Row with for loop that creates multiple children - should NOT trigger
    final widget7 = Row(
      children: [
        for (var i = 0; i < 3; i++) Text('Item $i'),
      ],
    );

    return Container();
  }
}
