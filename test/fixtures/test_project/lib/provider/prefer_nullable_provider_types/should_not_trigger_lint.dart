// ignore_for_file: unused_local_variable, avoid_read_inside_build, prefer_provider_extensions

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
