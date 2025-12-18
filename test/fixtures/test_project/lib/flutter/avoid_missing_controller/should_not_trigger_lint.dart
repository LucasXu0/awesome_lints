import 'package:flutter/material.dart';

void notTrigger() {
  final controller = TextEditingController();

  // TextField with controller - correct
  TextField(
    controller: controller,
  );

  // TextFormField with controller - correct
  TextFormField(
    controller: controller, // ignore: avoid_undisposed_instances
  );

  // TextField with onChanged - correct
  TextField(
    onChanged: (value) {
      print(value);
    },
  );

  // TextFormField with onChanged - correct
  TextFormField(
    onChanged: (value) {},
  );

  // TextFormField with onSaved - correct
  TextFormField(
    onSaved: (value) {
      print(value);
    },
  );

  // TextField with both controller and onChanged - correct
  TextField(
    controller: controller,
    onChanged: (value) {},
  );
}
