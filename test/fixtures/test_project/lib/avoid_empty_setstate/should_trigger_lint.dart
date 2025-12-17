import 'package:flutter/material.dart';

// ignore_for_file: unused_element, unused_field

class ShouldTriggerLint extends StatefulWidget {
  const ShouldTriggerLint({super.key});

  @override
  State<ShouldTriggerLint> createState() => _ShouldTriggerLintState();
}

class _ShouldTriggerLintState extends State<ShouldTriggerLint> {
  int _counter = 0;

  // Case 1: Empty block setState - should trigger
  void _emptyBlockSetState() {
    // expect_lint: avoid_empty_setstate
    setState(() {});
  }

  // Case 2: Expression function returning null - should trigger
  void _expressionNullSetState() {
    // expect_lint: avoid_empty_setstate
    setState(() => null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Test')),
      body: Center(
        child: Text('Counter: $_counter'),
      ),
    );
  }
}