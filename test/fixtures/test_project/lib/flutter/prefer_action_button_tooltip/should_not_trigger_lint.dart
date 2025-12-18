import 'package:flutter/material.dart';

void notTrigger() {
  IconButton(
    icon: Icon(Icons.add),
    onPressed: () {},
    tooltip: 'Add item',
  );

  IconButton(
    icon: Icon(Icons.delete),
    onPressed: () {},
    tooltip: 'Delete item',
    iconSize: 24.0,
  );

  FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.add),
    tooltip: 'Add new item',
  );

  FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.edit),
    backgroundColor: Colors.blue,
    tooltip: 'Edit',
  );

  FloatingActionButton.extended(
    onPressed: () {},
    label: Text('Add'),
    icon: Icon(Icons.add),
    tooltip: 'Add new entry',
  );

  // Not an action button, should not trigger
  TextButton(
    onPressed: () {},
    child: Text('Click me'),
  );

  // Not an action button, should not trigger
  ElevatedButton(
    onPressed: () {},
    child: Text('Submit'),
  );
}
