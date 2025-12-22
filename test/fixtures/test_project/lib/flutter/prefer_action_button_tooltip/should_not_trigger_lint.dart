import 'package:flutter/material.dart';

void notTrigger() {
  IconButton(onPressed: () {}, tooltip: 'Add item', icon: Icon(Icons.add));

  IconButton(
    iconSize: 24.0,
    onPressed: () {},
    tooltip: 'Delete item',
    icon: Icon(Icons.delete),
  );

  FloatingActionButton(
    child: Icon(Icons.add),
    tooltip: 'Add new item',
    onPressed: () {},
  );

  FloatingActionButton(
    child: Icon(Icons.edit),
    tooltip: 'Edit',
    backgroundColor: Colors.blue,
    onPressed: () {},
  );

  FloatingActionButton.extended(
    tooltip: 'Add new entry',
    onPressed: () {},
    icon: Icon(Icons.add),
    label: Text('Add'),
  );

  // Not an action button, should not trigger
  TextButton(onPressed: () {}, child: Text('Click me'));

  // Not an action button, should not trigger
  ElevatedButton(onPressed: () {}, child: Text('Submit'));
}
