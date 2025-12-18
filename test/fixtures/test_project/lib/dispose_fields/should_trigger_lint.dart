import 'dart:async';

import 'package:flutter/material.dart';

// ignore_for_file: unused_field

// Case 1: TextEditingController not disposed - should trigger
class MyWidget1 extends StatefulWidget {
  const MyWidget1({super.key});

  @override
  State<MyWidget1> createState() => _MyWidget1State();
}

class _MyWidget1State extends State<MyWidget1> {
  // expect_lint: dispose_fields
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 2: StreamController not closed - should trigger
class MyWidget2 extends StatefulWidget {
  const MyWidget2({super.key});

  @override
  State<MyWidget2> createState() => _MyWidget2State();
}

class _MyWidget2State extends State<MyWidget2> {
  // expect_lint: dispose_fields
  final StreamController<int> _streamController = StreamController<int>();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 3: Has dispose method but doesn't dispose the field - should trigger
class MyWidget3 extends StatefulWidget {
  const MyWidget3({super.key});

  @override
  State<MyWidget3> createState() => _MyWidget3State();
}

class _MyWidget3State extends State<MyWidget3> {
  // expect_lint: dispose_fields
  final TextEditingController _controller = TextEditingController();

  // expect_lint: avoid_unnecessary_overrides_in_state
  @override
  void dispose() {
    // Field not disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 4: Multiple fields, only one disposed - should trigger for the undisposed field
class MyWidget4 extends StatefulWidget {
  const MyWidget4({super.key});

  @override
  State<MyWidget4> createState() => _MyWidget4State();
}

class _MyWidget4State extends State<MyWidget4> {
  final TextEditingController _controller1 = TextEditingController();
  // expect_lint: dispose_fields
  final TextEditingController _controller2 = TextEditingController();

  @override
  void dispose() {
    _controller1.dispose();
    // _controller2 not disposed - should trigger
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 5: AnimationController not disposed - should trigger
class MyWidget5 extends StatefulWidget {
  const MyWidget5({super.key});

  @override
  State<MyWidget5> createState() => _MyWidget5State();
}

class _MyWidget5State extends State<MyWidget5>
    with SingleTickerProviderStateMixin {
  // expect_lint: dispose_fields
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 6: FocusNode not disposed - should trigger
class MyWidget6 extends StatefulWidget {
  const MyWidget6({super.key});

  @override
  State<MyWidget6> createState() => _MyWidget6State();
}

class _MyWidget6State extends State<MyWidget6> {
  // expect_lint: dispose_fields
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
