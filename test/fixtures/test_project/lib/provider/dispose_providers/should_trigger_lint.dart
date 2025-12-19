// ignore_for_file: unused_local_variable

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class DisposableService {
  void dispose() {
    // cleanup
  }
}

class ClosableService {
  void close() {
    // cleanup
  }
}

class ShouldTriggerLint extends StatelessWidget {
  const ShouldTriggerLint({super.key});

  @override
  Widget build(BuildContext context) {
    // expect_lint: dispose_providers
    return Provider<DisposableService>(
      create: (_) => DisposableService(),
      // Missing dispose callback
      child: Container(),
    );
  }
}

class AnotherExample extends StatelessWidget {
  const AnotherExample({super.key});

  @override
  Widget build(BuildContext context) {
    // expect_lint: dispose_providers
    return Provider<ClosableService>(
      create: (_) => ClosableService(),
      // Missing dispose callback for close()
      child: Container(),
    );
  }
}
