import 'package:flutter/material.dart';

class ShouldNotTriggerLint extends StatefulWidget {
  const ShouldNotTriggerLint({super.key});

  @override
  State<ShouldNotTriggerLint> createState() => _ShouldNotTriggerLintState();
}

class _ShouldNotTriggerLintState extends State<ShouldNotTriggerLint> {
  int _counter = 0;

  // Case 1: setState with statements - should NOT trigger
  void _incrementCounter1() {
    setState(() {
      _counter++;
    });
  }

  // Case 2: setState with expression with side effects - should NOT trigger
  void _incrementCounter2() {
    setState(() => _counter++);
  }

  // Case 3: setState with multiple statements - should NOT trigger
  void _incrementCounter3() {
    setState(() {
      _counter++;
      print('Counter incremented');
    });
  }

  // Case 4: setState with conditional logic - should NOT trigger
  void _incrementCounter4() {
    setState(() {
      if (_counter < 10) {
        _counter++;
      }
    });
  }

  // Case 5: setState with assignment - should NOT trigger
  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  // Case 6: setState with expression function returning a value - should NOT trigger
  void _incrementCounter6() {
    setState(() => _counter = _counter + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Test')),
      body: Center(child: Text('Counter: $_counter')),
    );
  }
}
