import 'package:flutter/material.dart';

// Case 1: initState with super call NOT first - should trigger
class MyWidget1 extends StatefulWidget {
  const MyWidget1({super.key});

  @override
  State<MyWidget1> createState() => _MyWidget1State();
}

class _MyWidget1State extends State<MyWidget1> {
  // expect_lint: proper_super_calls
  @override
  void initState() {
    final x = 1; // Some code before super
    super.initState(); // Super should be first
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 2: dispose with super call NOT last - should trigger
class MyWidget2 extends StatefulWidget {
  const MyWidget2({super.key});

  @override
  State<MyWidget2> createState() => _MyWidget2State();
}

class _MyWidget2State extends State<MyWidget2> {
  // expect_lint: proper_super_calls
  @override
  void dispose() {
    super.dispose(); // Super should be last
    final x = 1; // Some code after super
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 3: didUpdateWidget with super call NOT first - should trigger
class MyWidget3 extends StatefulWidget {
  const MyWidget3({super.key});

  @override
  State<MyWidget3> createState() => _MyWidget3State();
}

class _MyWidget3State extends State<MyWidget3> {
  // expect_lint: proper_super_calls
  @override
  void didUpdateWidget(MyWidget3 oldWidget) {
    final x = 1; // Some code before super
    super.didUpdateWidget(oldWidget); // Super should be first
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 4: deactivate with super call NOT last - should trigger
class MyWidget4 extends StatefulWidget {
  const MyWidget4({super.key});

  @override
  State<MyWidget4> createState() => _MyWidget4State();
}

class _MyWidget4State extends State<MyWidget4> {
  // expect_lint: proper_super_calls
  @override
  void deactivate() {
    super.deactivate(); // Super should be last
    final x = 1; // Some code after super
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
