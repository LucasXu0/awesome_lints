// ignore_for_file: unused_local_variable, prefer_nullable_provider_types, avoid_read_inside_build

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
