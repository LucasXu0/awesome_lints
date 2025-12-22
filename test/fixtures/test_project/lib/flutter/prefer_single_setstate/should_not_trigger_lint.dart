import 'package:flutter/material.dart';

class ShouldNotTriggerLint extends StatefulWidget {
  const ShouldNotTriggerLint({super.key});

  @override
  State<ShouldNotTriggerLint> createState() => _ShouldNotTriggerLintState();
}

class _ShouldNotTriggerLintState extends State<ShouldNotTriggerLint> {
  int _counter = 0;
  String _message = '';
  bool _isLoading = false;

  // Case 1: Single setState call - should NOT trigger
  void _singleSetState() {
    setState(() {
      _counter++;
    });
  }

  // Case 2: setState calls separated by other logic - should NOT trigger
  void _setStateWithLogicBetween() {
    setState(() {
      _counter++;
    });
    print('Counter updated');
    setState(() {
      _message = 'Updated';
    });
  }

  // Case 3: setState in different control flow branches - should NOT trigger
  void _setStateInDifferentBranches() {
    if (_counter > 0) {
      setState(() {
        _counter--;
      });
    } else {
      setState(() {
        _counter++;
      });
    }
  }

  // Case 4: setState calls in different if blocks - should NOT trigger
  void _setStateInSeparateIfBlocks() {
    if (_counter > 5) {
      setState(() {
        _message = 'High';
      });
    }

    if (_isLoading) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Case 5: setState in loop - should NOT trigger
  void _setStateInLoop() {
    for (var i = 0; i < 3; i++) {
      setState(() {
        _counter++;
      });
    }
  }

  // Case 6: setState separated by variable declaration - should NOT trigger
  void _setStateWithDeclarationBetween() {
    setState(() {
      _counter++;
    });
    final newMessage = 'Counter is $_counter';
    setState(() {
      _message = newMessage;
    });
  }

  // Case 7: setState separated by function call - should NOT trigger
  void _setStateWithFunctionCallBetween() {
    setState(() {
      _counter = 0;
    });
    _logReset();
    setState(() {
      _message = 'Reset';
    });
  }

  void _logReset() {
    print('Reset called');
  }

  // Case 8: setState in switch statement - should NOT trigger
  void _setStateInSwitch(int value) {
    switch (value) {
      case 1:
        setState(() {
          _counter = 1;
        });
        break;

      case 2:
        setState(() {
          _counter = 2;
        });
        break;
    }
  }

  // Case 9: setState in while loop - should NOT trigger
  void _setStateInWhile() {
    var i = 0;
    while (i < 3) {
      setState(() {
        _counter++;
      });
      i++;
    }
  }

  // Case 10: No setState calls - should NOT trigger
  void _noSetState() {
    _counter++;
    _message = 'No setState';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Test')),
      body: Center(
        child: Column(
          children: [Text('Counter: $_counter'), Text('Message: $_message')],
        ),
      ),
    );
  }
}
