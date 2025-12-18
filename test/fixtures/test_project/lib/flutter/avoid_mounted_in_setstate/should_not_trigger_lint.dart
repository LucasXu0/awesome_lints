import 'package:flutter/material.dart';

// ignore_for_file: unused_element, unused_field, prefer_single_setstate

class ShouldNotTriggerLint extends StatefulWidget {
  const ShouldNotTriggerLint({super.key});

  @override
  State<ShouldNotTriggerLint> createState() => _ShouldNotTriggerLintState();
}

class _ShouldNotTriggerLintState extends State<ShouldNotTriggerLint> {
  int _counter = 0;

  // Case 1: mounted check before setState (correct pattern) - should NOT trigger
  void _incrementCounter1() async {
    await Future.delayed(Duration(seconds: 1));
    if (mounted) {
      setState(() {
        _counter++;
      });
    }
  }

  // Case 2: context.mounted check before setState (correct pattern) - should NOT trigger
  void _incrementCounter2() async {
    await Future.delayed(Duration(seconds: 1));
    if (context.mounted) {
      setState(() {
        _counter++;
      });
    }
  }

  // Case 3: mounted check with negation before setState - should NOT trigger
  void _incrementCounter3() async {
    await Future.delayed(Duration(seconds: 1));
    if (!mounted) {
      return;
    }
    setState(() {
      _counter++;
    });
  }

  // Case 4: setState without any mounted check - should NOT trigger
  void _incrementCounter4() {
    setState(() {
      _counter++;
    });
  }

  // Case 5: setState with other conditions inside, but no mounted check - should NOT trigger
  void _incrementCounter5() {
    setState(() {
      if (_counter < 10) {
        _counter++;
      }
    });
  }

  // Case 6: Multiple setState calls with mounted check before - should NOT trigger
  void _incrementCounter6() async {
    await Future.delayed(Duration(seconds: 1));
    if (!context.mounted) return;

    setState(() {
      _counter++;
    });

    setState(() {
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
