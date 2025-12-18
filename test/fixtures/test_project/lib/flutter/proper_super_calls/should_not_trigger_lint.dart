import 'package:flutter/material.dart';

// ignore_for_file: unused_field, unused_local_variable, unused_element

// Case 1: initState with super call first - should NOT trigger
class MyWidget1 extends StatefulWidget {
  const MyWidget1({super.key});

  @override
  State<MyWidget1> createState() => _MyWidget1State();
}

class _MyWidget1State extends State<MyWidget1> {
  @override
  void initState() {
    super.initState(); // Correct: super is first
    final x = 1; // Code after super is fine
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 2: dispose with super call last - should NOT trigger
class MyWidget2 extends StatefulWidget {
  const MyWidget2({super.key});

  @override
  State<MyWidget2> createState() => _MyWidget2State();
}

class _MyWidget2State extends State<MyWidget2> {
  @override
  void dispose() {
    final x = 1; // Code before super is fine
    super.dispose(); // Correct: super is last
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 3: didUpdateWidget with super call first - should NOT trigger
class MyWidget3 extends StatefulWidget {
  const MyWidget3({super.key});

  @override
  State<MyWidget3> createState() => _MyWidget3State();
}

class _MyWidget3State extends State<MyWidget3> {
  @override
  void didUpdateWidget(MyWidget3 oldWidget) {
    super.didUpdateWidget(oldWidget); // Correct: super is first
    final x = 1; // Code after super is fine
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 4: activate with super call first - should NOT trigger
class MyWidget4 extends StatefulWidget {
  const MyWidget4({super.key});

  @override
  State<MyWidget4> createState() => _MyWidget4State();
}

class _MyWidget4State extends State<MyWidget4> {
  int _counter = 0;

  @override
  void activate() {
    super.activate(); // Correct: super is first
    _counter++; // Use state
  }

  @override
  Widget build(BuildContext context) {
    return Text('$_counter');
  }
}

// Case 5: deactivate with super call last - should NOT trigger
class MyWidget5 extends StatefulWidget {
  const MyWidget5({super.key});

  @override
  State<MyWidget5> createState() => _MyWidget5State();
}

class _MyWidget5State extends State<MyWidget5> {
  @override
  void deactivate() {
    final x = 1; // Code before super is fine
    super.deactivate(); // Correct: super is last
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 7: Lifecycle method with no super call should NOT trigger
class MyWidget7 extends StatefulWidget {
  const MyWidget7({super.key});

  @override
  State<MyWidget7> createState() => _MyWidget7State();
}

class _MyWidget7State extends State<MyWidget7> {
  @override
  void didUpdateWidget(MyWidget7 oldWidget) {
    super.didUpdateWidget(oldWidget);
    final x = 1; // No super call at all - not our concern
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 8: Widget with state usage - should NOT trigger
class MyWidget8 extends StatefulWidget {
  const MyWidget8({super.key});

  @override
  State<MyWidget8> createState() => _MyWidget8State();
}

class _MyWidget8State extends State<MyWidget8> {
  int _value = 0;

  void _increment() {
    setState(() {
      _value++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text('$_value');
  }
}
