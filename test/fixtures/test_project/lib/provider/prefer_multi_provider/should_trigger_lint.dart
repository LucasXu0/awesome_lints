// ignore_for_file: prefer_async_await, prefer_contains, prefer_correct_for_loop_increment, prefer_early_return, prefer_iterable_of, prefer_named_boolean_parameters, prefer_switch_expression, unused_local_variable

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ServiceA {}

class ServiceB {}

class ServiceC {}

class ShouldTriggerLint extends StatelessWidget {
  const ShouldTriggerLint({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<ServiceA>(
      create: (_) => ServiceA(),
      // expect_lint: prefer_multi_provider
      child: Provider<ServiceB>(create: (_) => ServiceB(), child: Container()),
    );
  }
}

class AnotherExample extends StatelessWidget {
  const AnotherExample({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: dispose_providers
    return ChangeNotifierProvider<MyNotifier>(
      create: (_) => MyNotifier(),
      // expect_lint: prefer_multi_provider
      child: Provider<ServiceA>(create: (_) => ServiceA(), child: Container()),
    );
  }
}

class MyNotifier extends ChangeNotifier {}
