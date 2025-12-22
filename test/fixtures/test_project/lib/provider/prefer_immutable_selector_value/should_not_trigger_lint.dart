import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class MyModel extends ChangeNotifier {
  int value = 0;
}

class ShouldNotTriggerLint extends StatelessWidget {
  const ShouldNotTriggerLint({super.key});

  @override
  Widget build(BuildContext context) {
    // Selecting primitive types is fine
    return Selector<MyModel, int>(
      selector: (context, model) => model.value,
      builder: (context, value, child) => Text('$value'),
    );
  }
}

class AnotherExample extends StatelessWidget {
  const AnotherExample({super.key});

  @override
  Widget build(BuildContext context) {
    // Selecting String is fine
    return Selector<MyModel, String>(
      selector: (context, model) => 'Value: ${model.value}',
      builder: (context, text, child) => Text(text),
    );
  }
}
