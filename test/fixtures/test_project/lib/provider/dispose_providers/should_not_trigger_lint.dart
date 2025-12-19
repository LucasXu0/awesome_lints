// ignore_for_file: no_empty_block, prefer_async_await, prefer_contains, prefer_correct_for_loop_increment, prefer_early_return, prefer_iterable_of, prefer_named_boolean_parameters, prefer_switch_expression, unused_local_variable

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class DisposableService {
  void dispose() {
    // cleanup
  }
}

class RegularService {
  // No dispose method
  void doSomething() {}
}

class ShouldNotTriggerLint extends StatelessWidget {
  const ShouldNotTriggerLint({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<DisposableService>(
      create: (_) => DisposableService(),
      dispose: (_, service) => service.dispose(), // Properly disposes
      child: Container(),
    );
  }
}

class AnotherExample extends StatelessWidget {
  const AnotherExample({super.key});

  @override
  Widget build(BuildContext context) {
    // Service without dispose method doesn't need dispose callback
    return Provider<RegularService>(
      create: (_) => RegularService(),
      child: Container(),
    );
  }
}
