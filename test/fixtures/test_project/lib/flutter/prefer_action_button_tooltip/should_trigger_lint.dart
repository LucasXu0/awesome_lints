import 'package:flutter/material.dart';

void trigger() {
  // expect_lint: prefer_action_button_tooltip
  IconButton(
    icon: Icon(Icons.add),
    onPressed: () {},
  );

  // expect_lint: prefer_action_button_tooltip
  IconButton(
    icon: Icon(Icons.delete),
    onPressed: () {},
    iconSize: 24.0,
  );

  // expect_lint: prefer_action_button_tooltip
  FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.add),
  );

  // expect_lint: prefer_action_button_tooltip
  FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.edit),
    backgroundColor: Colors.blue,
  );

  // expect_lint: prefer_action_button_tooltip
  FloatingActionButton.extended(
    onPressed: () {},
    label: Text('Add'),
    icon: Icon(Icons.add),
  );
}
