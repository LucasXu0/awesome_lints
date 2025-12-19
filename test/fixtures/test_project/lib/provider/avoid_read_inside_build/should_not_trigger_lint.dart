// ignore_for_file: prefer_async_await, prefer_contains, prefer_correct_for_loop_increment, prefer_early_return, prefer_iterable_of, prefer_named_boolean_parameters, prefer_nullable_provider_types, prefer_switch_expression, prefer_widget_private_members, unused_local_variable

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ShouldNotTriggerLint extends StatelessWidget {
  const ShouldNotTriggerLint({super.key});

  @override
  Widget build(BuildContext context) {
    // Using watch in build is correct
    final value = context.watch<String>();

    return Text(value);
  }

  void onPressed(BuildContext context) {
    // Using read outside build is fine
    final value = context.read<String>();
    print(value);
  }
}
