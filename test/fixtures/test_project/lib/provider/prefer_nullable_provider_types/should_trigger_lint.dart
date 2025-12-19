// ignore_for_file: unused_local_variable, avoid_read_inside_build, prefer_provider_extensions

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ShouldTriggerLint extends StatelessWidget {
  const ShouldTriggerLint({super.key});

  @override
  Widget build(BuildContext context) {
    // expect_lint: prefer_nullable_provider_types
    final value1 = context.watch<String>();

    // expect_lint: prefer_nullable_provider_types
    final value2 = context.read<int>();

    // expect_lint: prefer_nullable_provider_types
    final value3 = context.select<String, int>((value) => value.length);

    // expect_lint: prefer_nullable_provider_types
    final value4 = Provider.of<String>(context);

    return Container();
  }
}
