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
