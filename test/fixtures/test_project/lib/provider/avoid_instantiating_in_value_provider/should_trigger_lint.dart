// ignore_for_file: avoid_undisposed_instances, newline_before_constructor, prefer_async_await, prefer_contains, prefer_correct_for_loop_increment, prefer_early_return, prefer_iterable_of, prefer_named_boolean_parameters, prefer_switch_expression, unused_local_variable

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class MyService {
  final String name;
  MyService(this.name);
}

class ShouldTriggerLint extends StatelessWidget {
  const ShouldTriggerLint({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<MyService>.value(
      // expect_lint: avoid_instantiating_in_value_provider
      value: MyService('test'),
      child: Container(),
    );
  }
}

class AnotherExample extends StatelessWidget {
  const AnotherExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyNotifier>.value(
      // expect_lint: avoid_instantiating_in_value_provider
      value: MyNotifier(),
      child: Container(),
    );
  }
}

class MyNotifier extends ChangeNotifier {}
