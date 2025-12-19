// ignore_for_file: avoid_read_inside_build, prefer_async_await, prefer_contains, prefer_correct_for_loop_increment, prefer_early_return, prefer_iterable_of, prefer_named_boolean_parameters, prefer_nullable_provider_types, prefer_switch_expression, unused_local_variable

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ShouldNotTriggerLint extends StatelessWidget {
  const ShouldNotTriggerLint({super.key});

  @override
  Widget build(BuildContext context) {
    // Using context.watch() is good
    final value1 = context.watch<String>();

    // Using context.read() is good
    final value2 = context.read<int>();

    // Using context.select() is good
    final value3 = context.select<String, int>((value) => value.length);

    return Container();
  }
}
