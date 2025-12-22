import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ShouldTriggerLint extends StatelessWidget {
  const ShouldTriggerLint({super.key});

  @override
  Widget build(BuildContext context) {
    // expect_lint: avoid_read_inside_build
    final value = context.read<String>();

    return Text(value);
  }
}

class AnotherExample extends StatelessWidget {
  const AnotherExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // expect_lint: avoid_read_inside_build
        Text(context.read<String>()),
      ],
    );
  }
}
