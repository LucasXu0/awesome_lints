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
