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
