import 'package:flutter/material.dart';

// ignore_for_file: unused_element, unused_field, avoid_unnecessary_stateful_widgets

// Case 1: Public method in State class - should trigger
class MyWidget1 extends StatefulWidget {
  const MyWidget1({super.key});

  @override
  State<MyWidget1> createState() => _MyWidget1State();
}

class _MyWidget1State extends State<MyWidget1> {
  // expect_lint: prefer_widget_private_members
  void publicMethod() {
    // Public method should trigger
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 2: Public field in State class - should trigger
class MyWidget2 extends StatefulWidget {
  const MyWidget2({super.key});

  @override
  State<MyWidget2> createState() => _MyWidget2State();
}

class _MyWidget2State extends State<MyWidget2> {
  // expect_lint: prefer_widget_private_members
  String publicField = 'test';

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 3: Public getter in State class - should trigger
class MyWidget3 extends StatefulWidget {
  const MyWidget3({super.key});

  @override
  State<MyWidget3> createState() => _MyWidget3State();
}

class _MyWidget3State extends State<MyWidget3> {
  // expect_lint: prefer_widget_private_members
  String get publicGetter => 'test';

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 4: Public setter in State class - should trigger
class MyWidget4 extends StatefulWidget {
  const MyWidget4({super.key});

  @override
  State<MyWidget4> createState() => _MyWidget4State();
}

class _MyWidget4State extends State<MyWidget4> {
  String _value = '';

  // expect_lint: prefer_widget_private_members
  set publicSetter(String value) {
    _value = value;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 5: Multiple public members in State class - should trigger for each
class MyWidget5 extends StatefulWidget {
  const MyWidget5({super.key});

  @override
  State<MyWidget5> createState() => _MyWidget5State();
}

class _MyWidget5State extends State<MyWidget5> {
  // expect_lint: prefer_widget_private_members
  String publicField1 = 'test1';
  // expect_lint: prefer_widget_private_members
  int publicField2 = 42;

  // expect_lint: prefer_widget_private_members
  void publicMethod1() {}

  // expect_lint: prefer_widget_private_members
  void publicMethod2() {}

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 6: Public method in StatefulWidget - should trigger
class MyWidget6 extends StatefulWidget {
  const MyWidget6({super.key});

  // expect_lint: prefer_widget_private_members
  void publicHelperMethod() {
    // Public method in StatefulWidget should trigger
  }

  @override
  State<MyWidget6> createState() => _MyWidget6State();
}

class _MyWidget6State extends State<MyWidget6> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 8: Public method in StatelessWidget - should trigger
class MyWidget8 extends StatelessWidget {
  const MyWidget8({super.key});

  // expect_lint: prefer_widget_private_members
  void publicMethod() {
    // Public method in StatelessWidget should trigger
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 10: Public late field in State class - should trigger
class MyWidget10 extends StatefulWidget {
  const MyWidget10({super.key});

  @override
  State<MyWidget10> createState() => _MyWidget10State();
}

class _MyWidget10State extends State<MyWidget10> {
  // expect_lint: prefer_widget_private_members
  late String publicLateField;

  @override
  void initState() {
    super.initState();
    publicLateField = 'initialized';
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 11: Public async method in State class - should trigger
class MyWidget11 extends StatefulWidget {
  const MyWidget11({super.key});

  @override
  State<MyWidget11> createState() => _MyWidget11State();
}

class _MyWidget11State extends State<MyWidget11> {
  // expect_lint: prefer_widget_private_members
  Future<void> publicAsyncMethod() async {
    // Public async method should trigger
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
