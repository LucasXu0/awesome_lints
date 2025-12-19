// ignore_for_file: prefer_async_await, prefer_contains, prefer_correct_for_loop_increment, prefer_early_return, prefer_iterable_of, prefer_named_boolean_parameters, prefer_nullable_provider_types, prefer_switch_expression, unused_local_variable

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ShouldTriggerLint extends StatelessWidget {
  const ShouldTriggerLint({super.key});

  @override
  Widget build(BuildContext context) {
    // expect_lint: prefer_provider_extensions
    final value1 = Provider.of<String>(context);

    // expect_lint: prefer_provider_extensions
    final value2 = Provider.of<String>(context, listen: false);

    // expect_lint: prefer_provider_extensions
    final value3 = Provider.of<int>(context, listen: true);

    return Container();
  }
}
