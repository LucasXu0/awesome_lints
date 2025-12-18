import 'package:flutter/widgets.dart';

void notTrigger() {
  final items = ['a', 'b', 'c'];

  // Using for-loop - correct approach
  Column(
    children: [
      for (final item in items) Text(item),
    ],
  );

  // Using for-loop with index
  Row(
    children: [
      for (var i = 0; i < items.length; i++) Text(items[i]),
    ],
  );

  // Manual list
  Column(
    children: [
      Text('a'),
      Text('b'),
      Text('c'),
    ],
  );

  // Empty list
  Row(
    children: [],
  );

  // Explicit list
  Column(
    children: [
      Text('a'),
      Text('b'),
    ],
  );

  // List.generate is acceptable when used appropriately in other contexts
  final widgets = List.generate(5, (index) => Text('$index'));
}
