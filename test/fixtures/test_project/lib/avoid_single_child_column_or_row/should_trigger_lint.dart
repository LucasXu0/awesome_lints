import 'package:flutter/widgets.dart';

// ignore_for_file: unused_local_variable, prefer_const_constructors

class ShouldTriggerLint extends StatelessWidget {
  const ShouldTriggerLint({super.key});

  @override
  Widget build(BuildContext context) {
    // Case 1: Column with single child - should trigger
    final widget1 = Column(
      children: [
        Text('Single child'),
      ],
    );

    // Case 2: Row with single child - should trigger
    final widget2 = Row(
      children: [
        Text('Single child'),
      ],
    );

    // Case 3: Column with single child and properties - should trigger
    final widget3 = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 100,
          height: 100,
          child: Text('Hello'),
        ),
      ],
    );

    // Case 4: Row with single child and properties - should trigger
    final widget4 = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(child: Text('Hello')),
      ],
    );

    // Case 5: Nested - inner Column with single child should trigger
    final widget5 = Column(
      children: [
        Text('First'),
        Column(
          children: [
            Text('Nested single child'),
          ],
        ),
      ],
    );

    return Container();
  }
}
