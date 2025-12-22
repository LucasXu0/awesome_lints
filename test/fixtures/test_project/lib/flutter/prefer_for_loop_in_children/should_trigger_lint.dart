import 'package:flutter/widgets.dart';

void trigger() {
  final items = ['a', 'b', 'c'];

  // expect_lint: prefer_for_loop_in_children
  Column(children: items.map((item) => Text(item)).toList());

  // expect_lint: prefer_for_loop_in_children
  Row(children: [...items.map((item) => Text(item)).toList()]);

  // expect_lint: prefer_for_loop_in_children
  Row(
    children: items.fold<List<Widget>>([], (list, item) {
      return [...list, Text(item)];
    }),
  );
}
