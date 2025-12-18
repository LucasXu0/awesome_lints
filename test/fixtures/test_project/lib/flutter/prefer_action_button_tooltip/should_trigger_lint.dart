import 'package:flutter/material.dart';

void trigger() {
  // expect_lint: prefer_action_button_tooltip
  IconButton(
    onPressed: () {},
    icon: Icon(Icons.add),
  );

  // expect_lint: prefer_action_button_tooltip
  IconButton(
    iconSize: 24.0,
    onPressed: () {},
    icon: Icon(Icons.delete),
  );

  // expect_lint: prefer_action_button_tooltip
  FloatingActionButton(
    child: Icon(Icons.add),
    onPressed: () {},
  );

  // expect_lint: prefer_action_button_tooltip
  FloatingActionButton(
    child: Icon(Icons.edit),
    backgroundColor: Colors.blue,
    onPressed: () {},
  );

  // expect_lint: prefer_action_button_tooltip
  FloatingActionButton.extended(
    onPressed: () {},
    icon: Icon(Icons.add),
    label: Text('Add'),
  );
}
