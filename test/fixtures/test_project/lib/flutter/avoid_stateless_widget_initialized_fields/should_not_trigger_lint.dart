import 'package:flutter/material.dart';

// Static fields are allowed
class MyWidget1 extends StatelessWidget {
  static final items = [];

  const MyWidget1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Fields without initializers are allowed
class MyWidget2 extends StatelessWidget {
  final int count;

  const MyWidget2(this.count, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text('$count');
  }
}

// No fields at all
class MyWidget3 extends StatelessWidget {
  const MyWidget3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// StatefulWidget can have initialized fields
class MyWidget4 extends StatefulWidget {
  const MyWidget4({super.key});

  @override
  State<MyWidget4> createState() => _MyWidget4State();
}

class _MyWidget4State extends State<MyWidget4> {
  final items = [];

  final count = 0;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Regular class (not a widget)
class MyClass {
  final items = [];
  final count = 0;
}

// Static const fields
class MyWidget5 extends StatelessWidget {
  static const String title = 'Hello';

  const MyWidget5({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(title);
  }
}
