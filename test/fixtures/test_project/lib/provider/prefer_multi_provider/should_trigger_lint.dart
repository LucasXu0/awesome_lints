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
