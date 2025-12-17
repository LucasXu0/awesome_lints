import 'package:flutter/material.dart';

// ignore_for_file: unused_element, unused_field

class ShouldTriggerLint extends StatefulWidget {
  const ShouldTriggerLint({super.key});

  @override
  State<ShouldTriggerLint> createState() => _ShouldTriggerLintState();
}

class _ShouldTriggerLintState extends State<ShouldTriggerLint> {
  int _counter = 0;

  // Case 1: mounted check inside setState - should trigger
  void _incrementCounter1() async {
    await Future.delayed(Duration(seconds: 1));
    // expect_lint: avoid_mounted_in_setstate
    setState(() {
      if (mounted) {
        _counter++;
      }
    });
  }

  // Case 2: context.mounted check inside setState - should trigger
  void _incrementCounter2() async {
    await Future.delayed(Duration(seconds: 1));
    // expect_lint: avoid_mounted_in_setstate
    setState(() {
      if (context.mounted) {
        _counter++;
      }
    });
  }

  // Case 3: mounted check with negation inside setState - should trigger
  void _incrementCounter3() async {
    await Future.delayed(Duration(seconds: 1));
    // expect_lint: avoid_mounted_in_setstate
    setState(() {
      if (!mounted) {
        return;
      }
      _counter++;
    });
  }

  // Case 4: mounted check inside setState with early return - should trigger
  void _incrementCounter4() async {
    await Future.delayed(Duration(seconds: 1));
    // expect_lint: avoid_mounted_in_setstate
    setState(() {
      if (!context.mounted) return;
      _counter++;
    });
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