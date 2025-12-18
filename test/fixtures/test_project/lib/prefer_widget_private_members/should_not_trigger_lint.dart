import 'package:flutter/material.dart';

// ignore_for_file: unused_element, unused_field, avoid_unnecessary_stateful_widgets

// Case 1: Private method in State class - should NOT trigger
class MyWidget1 extends StatefulWidget {
  const MyWidget1({super.key});

  @override
  State<MyWidget1> createState() => _MyWidget1State();
}

class _MyWidget1State extends State<MyWidget1> {
  void _privateMethod() {
    // Private method should not trigger
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 2: Private field in State class - should NOT trigger
class MyWidget2 extends StatefulWidget {
  const MyWidget2({super.key});

  @override
  State<MyWidget2> createState() => _MyWidget2State();
}

class _MyWidget2State extends State<MyWidget2> {
  final String _privateField = 'test';

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 3: Standard lifecycle methods in State class - should NOT trigger
class MyWidget3 extends StatefulWidget {
  const MyWidget3({super.key});

  @override
  State<MyWidget3> createState() => _MyWidget3State();
}

class _MyWidget3State extends State<MyWidget3> {
  // ignore: avoid_unnecessary_overrides_in_state
  @override
  void initState() {
    super.initState();
  }

  // ignore: avoid_unnecessary_overrides_in_state
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  // ignore: avoid_unnecessary_overrides_in_state
  @override
  void didUpdateWidget(MyWidget3 oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  // ignore: avoid_unnecessary_overrides_in_state
  @override
  void reassemble() {
    super.reassemble();
  }

  // ignore: avoid_unnecessary_overrides_in_state
  @override
  void deactivate() {
    super.deactivate();
  }

  // ignore: avoid_unnecessary_overrides_in_state
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 4: Static members in State class - should NOT trigger
class MyWidget4 extends StatefulWidget {
  const MyWidget4({super.key});

  @override
  State<MyWidget4> createState() => _MyWidget4State();
}

class _MyWidget4State extends State<MyWidget4> {
  static const String staticField = 'test';
  static void staticMethod() {}

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 5: Overridden methods in State class - should NOT trigger
class MyWidget5 extends StatefulWidget {
  const MyWidget5({super.key});

  @override
  State<MyWidget5> createState() => _MyWidget5State();
}

// Custom base state class
abstract class BaseState<T extends StatefulWidget> extends State<T> {
  // ignore: prefer_widget_private_members
  void customLifecycle() {}
}

class _MyWidget5State extends BaseState<MyWidget5> {
  @override
  void customLifecycle() {
    // Overridden method from base class - should not trigger
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 6: Private getter and setter in State class - should NOT trigger
class MyWidget6 extends StatefulWidget {
  const MyWidget6({super.key});

  @override
  State<MyWidget6> createState() => _MyWidget6State();
}

class _MyWidget6State extends State<MyWidget6> {
  String _value = '';

  String get _privateGetter => _value;

  set _privateSetter(String value) {
    _value = value;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 7: Non-Widget/State class - should NOT trigger
class RegularClass {
  void publicMethod() {
    // Not a Widget or State class
  }

  String publicField = 'test';
}

// Case 8: Private method in StatelessWidget - should NOT trigger
class MyWidget8 extends StatelessWidget {
  const MyWidget8({super.key});

  void _privateMethod() {}

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 9: Private field in StatelessWidget - should NOT trigger
class MyWidget9 extends StatelessWidget {
  const MyWidget9({super.key});

  final String _privateField = 'test';

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 10: Standard lifecycle methods in StatefulWidget - should NOT trigger
class MyWidget10 extends StatefulWidget {
  const MyWidget10({super.key});

  @override
  State<MyWidget10> createState() => _MyWidget10State();

  @override
  StatefulElement createElement() {
    return super.createElement();
  }
}

class _MyWidget10State extends State<MyWidget10> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 11: Mixed private and lifecycle methods - should NOT trigger
class MyWidget11 extends StatefulWidget {
  const MyWidget11({super.key});

  @override
  State<MyWidget11> createState() => _MyWidget11State();
}

class _MyWidget11State extends State<MyWidget11> {
  final String _privateField1 = 'test1';
  final int _privateField2 = 42;

  void _privateMethod1() {}
  void _privateMethod2() {}

  @override
  void initState() {
    super.initState();
    _privateMethod1();
  }

  @override
  void dispose() {
    _privateMethod2();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 12: Private late field in State class - should NOT trigger
class MyWidget12 extends StatefulWidget {
  const MyWidget12({super.key});

  @override
  State<MyWidget12> createState() => _MyWidget12State();
}

class _MyWidget12State extends State<MyWidget12> {
  late String _privateLateField;

  @override
  void initState() {
    super.initState();
    _privateLateField = 'initialized';
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 13: Private async method in State class - should NOT trigger
class MyWidget13 extends StatefulWidget {
  const MyWidget13({super.key});

  @override
  State<MyWidget13> createState() => _MyWidget13State();
}

class _MyWidget13State extends State<MyWidget13> {
  Future<void> _privateAsyncMethod() async {
    // Private async method should not trigger
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 14: Static fields in StatefulWidget - should NOT trigger
class MyWidget14 extends StatefulWidget {
  const MyWidget14({super.key});

  static const String staticField = 'test';

  @override
  State<MyWidget14> createState() => _MyWidget14State();
}

class _MyWidget14State extends State<MyWidget14> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 15: Private fields in StatefulWidget - should NOT trigger
class MyWidget15 extends StatefulWidget {
  const MyWidget15({super.key});

  final String _privateField = 'test';

  @override
  State<MyWidget15> createState() => _MyWidget15State();
}

class _MyWidget15State extends State<MyWidget15> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 16: Public field in StatefulWidget - should NOT trigger
class MyWidget16 extends StatefulWidget {
  const MyWidget16({super.key});

  final String publicField = 'test';

  @override
  State<MyWidget16> createState() => _MyWidget16State();
}

class _MyWidget16State extends State<MyWidget16> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 17: Public field in StatelessWidget - should NOT trigger
class MyWidget17 extends StatelessWidget {
  const MyWidget17({super.key});

  final String publicField = 'test';

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
