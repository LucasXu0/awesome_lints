// ignore_for_file: avoid_read_inside_build, prefer_async_await, prefer_contains, prefer_correct_for_loop_increment, prefer_early_return, prefer_iterable_of, prefer_named_boolean_parameters, prefer_provider_extensions, prefer_switch_expression, unused_local_variable

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ShouldNotTriggerLint extends StatelessWidget {
  const ShouldNotTriggerLint({super.key});

  @override
  Widget build(BuildContext context) {
    // Using nullable types is good
    final value1 = context.watch<String?>();

    final value2 = context.read<int?>();

    final value3 = context.select<String?, int>((value) => value?.length ?? 0);

    final value4 = Provider.of<String?>(context);

    return Container();
  }
}
