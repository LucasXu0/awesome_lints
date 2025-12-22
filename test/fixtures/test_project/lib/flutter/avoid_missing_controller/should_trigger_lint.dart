import 'package:flutter/material.dart';

void trigger() {
  // expect_lint: avoid_missing_controller
  TextField();

  // expect_lint: avoid_missing_controller
  TextFormField();

  // expect_lint: avoid_missing_controller
  TextField(decoration: InputDecoration(hintText: 'Enter text'));

  // expect_lint: avoid_missing_controller
  TextFormField(
    decoration: InputDecoration(labelText: 'Name'),
    keyboardType: TextInputType.text,
  );
}
