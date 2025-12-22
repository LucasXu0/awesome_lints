import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ShouldNotTriggerLint extends StatelessWidget {
  const ShouldNotTriggerLint({super.key});

  @override
  Widget build(BuildContext context) {
    // Using watch inside build is correct
    final value = context.watch<String>();

    return ElevatedButton(
      onPressed: () {
        // Using read outside build is correct
        final value = context.read<String>();
        print(value);
      },
      child: Text(value),
    );
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
