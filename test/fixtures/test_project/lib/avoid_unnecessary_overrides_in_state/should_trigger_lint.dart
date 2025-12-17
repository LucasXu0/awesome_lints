import 'package:flutter/material.dart';

// ignore_for_file: unused_field

// Case 1: dispose() with only super call (block body) - should trigger
class MyWidget1 extends StatefulWidget {
  const MyWidget1({super.key});

  @override
  State<MyWidget1> createState() => _MyWidget1State();
}

class _MyWidget1State extends State<MyWidget1> {
  @override
  // expect_lint: avoid_unnecessary_overrides_in_state
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 2: initState() with only super call (expression body) - should trigger
class MyWidget2 extends StatefulWidget {
  const MyWidget2({super.key});

  @override
  State<MyWidget2> createState() => _MyWidget2State();
}

class _MyWidget2State extends State<MyWidget2> {
  @override
  // expect_lint: avoid_unnecessary_overrides_in_state
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 3: didUpdateWidget with only super call - should trigger
class MyWidget3 extends StatefulWidget {
  const MyWidget3({super.key});

  @override
  State<MyWidget3> createState() => _MyWidget3State();
}

class _MyWidget3State extends State<MyWidget3> {
  @override
  // expect_lint: avoid_unnecessary_overrides_in_state
  void didUpdateWidget(MyWidget3 oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 4: deactivate with only super call - should trigger
class MyWidget4 extends StatefulWidget {
  const MyWidget4({super.key});

  @override
  State<MyWidget4> createState() => _MyWidget4State();
}

class _MyWidget4State extends State<MyWidget4> {
  @override
  // expect_lint: avoid_unnecessary_overrides_in_state
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
