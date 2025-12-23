import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Case 1: TextEditingController properly disposed - should NOT trigger
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

// Case 2: StreamController properly closed - should NOT trigger
class MyWidget2 extends StatefulWidget {
  const MyWidget2({super.key});

  @override
  State<MyWidget2> createState() => _MyWidget2State();
}

class _MyWidget2State extends State<MyWidget2> {
  final StreamController<int> _streamController = StreamController<int>();

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 3: Multiple fields all properly disposed - should NOT trigger
class MyWidget3 extends StatefulWidget {
  const MyWidget3({super.key});

  @override
  State<MyWidget3> createState() => _MyWidget3State();
}

class _MyWidget3State extends State<MyWidget3> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 4: AnimationController properly disposed - should NOT trigger
class MyWidget4 extends StatefulWidget {
  const MyWidget4({super.key});

  @override
  State<MyWidget4> createState() => _MyWidget4State();
}

class _MyWidget4State extends State<MyWidget4>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 5: FocusNode properly disposed - should NOT trigger
class MyWidget5 extends StatefulWidget {
  const MyWidget5({super.key});

  @override
  State<MyWidget5> createState() => _MyWidget5State();
}

class _MyWidget5State extends State<MyWidget5> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 6: No disposable fields - should NOT trigger
class MyWidget6 extends StatefulWidget {
  const MyWidget6({super.key});

  @override
  State<MyWidget6> createState() => _MyWidget6State();
}

class _MyWidget6State extends State<MyWidget6> {
  final String _text = 'Hello';
  final int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 7: Field disposed using this keyword - should NOT trigger
class MyWidget7 extends StatefulWidget {
  const MyWidget7({super.key});

  @override
  State<MyWidget7> createState() => _MyWidget7State();
}

class _MyWidget7State extends State<MyWidget7> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    this._controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 8: Field disposed in conditional - should NOT trigger
class MyWidget8 extends StatefulWidget {
  const MyWidget8({super.key});

  @override
  State<MyWidget8> createState() => _MyWidget8State();
}

class _MyWidget8State extends State<MyWidget8> {
  final TextEditingController? _controller = TextEditingController();

  @override
  void dispose() {
    if (_controller != null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 9: StatelessWidget - should NOT trigger (not a State class)
class MyWidget9 extends StatelessWidget {
  MyWidget9({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 10: Field from context.read() - externally owned, should NOT trigger
class MyWidget10 extends StatefulWidget {
  const MyWidget10({super.key});

  @override
  State<MyWidget10> createState() => _MyWidget10State();
}

class _MyWidget10State extends State<MyWidget10> {
  late final TextEditingController controller = context
      .read<TextEditingController>();

  @override
  void dispose() {
    // Should NOT dispose - it's owned by the provider
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 11: Field from widget parameter - externally owned, should NOT trigger
class MyWidget11 extends StatefulWidget {
  final TextEditingController controller;

  const MyWidget11({super.key, required this.controller});

  @override
  State<MyWidget11> createState() => _MyWidget11State();
}

class _MyWidget11State extends State<MyWidget11> {
  late final TextEditingController controller = widget.controller;

  @override
  void dispose() {
    // Should NOT dispose - it's passed from parent
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 12: Field from Provider.of() - externally owned, should NOT trigger
class MyWidget12 extends StatefulWidget {
  const MyWidget12({super.key});

  @override
  State<MyWidget12> createState() => _MyWidget12State();
}

class _MyWidget12State extends State<MyWidget12> {
  late final StreamController controller = Provider.of<StreamController>(
    context,
    listen: false,
  );

  @override
  void dispose() {
    // Should NOT dispose - it's from Provider.of
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
