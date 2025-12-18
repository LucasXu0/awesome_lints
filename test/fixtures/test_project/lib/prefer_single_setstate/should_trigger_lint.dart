import 'package:flutter/material.dart';

// ignore_for_file: unused_element, unused_field

class ShouldTriggerLint extends StatefulWidget {
  const ShouldTriggerLint({super.key});

  @override
  State<ShouldTriggerLint> createState() => _ShouldTriggerLintState();
}

class _ShouldTriggerLintState extends State<ShouldTriggerLint> {
  int _counter = 0;
  String _message = '';
  bool _isLoading = false;

  // Case 1: Two consecutive setState calls - should trigger on second
  void _twoConsecutiveSetState() {
    setState(() {
      _counter++;
    });
    // expect_lint: prefer_single_setstate
    setState(() {
      _message = 'Updated';
    });
  }

  // Case 2: Three consecutive setState calls - should trigger on second and third
  void _threeConsecutiveSetState() {
    setState(() {
      _counter++;
    });
    // expect_lint: prefer_single_setstate
    setState(() {
      _message = 'Updated';
    });
    // expect_lint: prefer_single_setstate
    setState(() {
      _isLoading = false;
    });
  }

  // Case 3: Multiple consecutive setState calls with different content
  void _multipleConsecutiveSetState() {
    setState(() {
      _counter = 0;
    });
    // expect_lint: prefer_single_setstate
    setState(() {
      _message = '';
    });
  }

  // Case 4: Consecutive setState calls in block
  void _consecutiveInBlock() {
    {
      setState(() {
        _counter++;
      });
      // expect_lint: prefer_single_setstate
      setState(() {
        _message = 'Done';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Test')),
      body: Center(
        child: Column(
          children: [
            Text('Counter: $_counter'),
            Text('Message: $_message'),
          ],
        ),
      ),
    );
  }
}
