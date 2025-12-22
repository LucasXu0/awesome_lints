import 'package:flutter/material.dart';

class MyWidget1 extends StatelessWidget {
  // expect_lint: avoid_stateless_widget_initialized_fields
  final items = [];

  MyWidget1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MyWidget2 extends StatelessWidget {
  // expect_lint: avoid_stateless_widget_initialized_fields
  final count = 0;

  MyWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MyWidget3 extends StatelessWidget {
  // expect_lint: avoid_stateless_widget_initialized_fields
  final data = <String>{};

  MyWidget3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MyWidget4 extends StatelessWidget {
  // expect_lint: avoid_stateless_widget_initialized_fields
  late final value = 42;

  MyWidget4({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MyWidget5 extends StatelessWidget {
  // expect_lint: avoid_stateless_widget_initialized_fields
  final String text = 'Hello';

  const MyWidget5({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}
