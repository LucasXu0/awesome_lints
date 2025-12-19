// ignore_for_file: avoid_default_tostring, prefer_async_await, prefer_contains, prefer_correct_for_loop_increment, prefer_early_return, prefer_iterable_of, prefer_named_boolean_parameters, prefer_nullable_provider_types, prefer_switch_expression, prefer_widget_private_members, unused_local_variable

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ShouldTriggerLint extends StatelessWidget {
  const ShouldTriggerLint({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // expect_lint: avoid_watch_outside_build
        final value = context.watch<String>();
        print(value);
      },
      child: const Text('Press'),
    );
  }

  void onCallback(BuildContext context) {
    // expect_lint: avoid_watch_outside_build
    final value = context.watch<String>();

    // expect_lint: avoid_watch_outside_build
    final selected = context.select<String, int>((value) => value.length);

    print('$value $selected');
  }
}

class ElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const ElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => child;
}
