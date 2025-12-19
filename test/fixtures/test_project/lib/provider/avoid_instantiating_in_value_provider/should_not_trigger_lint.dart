// ignore_for_file: avoid_stateless_widget_initialized_fields, newline_before_constructor, prefer_async_await, prefer_contains, prefer_correct_for_loop_increment, prefer_early_return, prefer_iterable_of, prefer_named_boolean_parameters, prefer_switch_expression, unused_local_variable

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class MyService {
  final String name;
  MyService(this.name);
}

class ShouldNotTriggerLint extends StatelessWidget {
  final MyService existingService = MyService('existing');

  ShouldNotTriggerLint({super.key});

  @override
  Widget build(BuildContext context) {
    // Using existing instance is good
    return Provider<MyService>.value(
      value: existingService,
      child: Container(),
    );
  }
}

class AnotherExample extends StatelessWidget {
  const AnotherExample({super.key});

  @override
  Widget build(BuildContext context) {
    // Using Provider (not .value) with create is good
    return Provider<MyService>(
      create: (_) => MyService('test'),
      child: Container(),
    );
  }
}
