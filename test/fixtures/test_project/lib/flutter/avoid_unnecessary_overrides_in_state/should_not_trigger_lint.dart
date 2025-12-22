import 'package:flutter/material.dart';

// Case 1: dispose() with additional logic - should NOT trigger
class MyWidget1 extends StatefulWidget {
  const MyWidget1({super.key});

  @override
  State<MyWidget1> createState() => _MyWidget1State();
}

class _MyWidget1State extends State<MyWidget1> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 2: initState() with additional logic - should NOT trigger
class MyWidget2 extends StatefulWidget {
  const MyWidget2({super.key});

  @override
  State<MyWidget2> createState() => _MyWidget2State();
}

class _MyWidget2State extends State<MyWidget2> {
  @override
  void initState() {
    super.initState();
    // Additional initialization
    print('Initialized');
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 3: didUpdateWidget with additional logic - should NOT trigger
class MyWidget3 extends StatefulWidget {
  const MyWidget3({super.key});

  @override
  State<MyWidget3> createState() => _MyWidget3State();
}

class _MyWidget3State extends State<MyWidget3> {
  @override
  void didUpdateWidget(MyWidget3 oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Check for changes
    print('Widget updated');
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 4: Method with @protected annotation but has logic - should NOT trigger
class MyWidget4 extends StatefulWidget {
  const MyWidget4({super.key});

  @override
  State<MyWidget4> createState() => _MyWidget4State();
}

class _MyWidget4State extends State<MyWidget4> {
  @override
  @protected
  void dispose() {
    // Even with @protected, this has logic so should NOT trigger
    print('Cleaning up');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 5: Not a State class - should NOT trigger
class RegularClass {
  @override
  String toString() {
    return super.toString();
  }
}

// Case 6: Override with different logic - should NOT trigger
class MyWidget6 extends StatefulWidget {
  const MyWidget6({super.key});

  @override
  State<MyWidget6> createState() => _MyWidget6State();
}

class _MyWidget6State extends State<MyWidget6> {
  @override
  void didChangeDependencies() {
    // Different implementation
    print('Dependencies changed');
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 7: Method without override annotation - should NOT trigger
class MyWidget7 extends StatefulWidget {
  const MyWidget7({super.key});

  @override
  State<MyWidget7> createState() => _MyWidget7State();
}

class _MyWidget7State extends State<MyWidget7> {
  // This method is not marked as @override, so it won't be checked
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
