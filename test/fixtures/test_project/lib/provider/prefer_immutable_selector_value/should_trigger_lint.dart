import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class MyModel extends ChangeNotifier {
  int value = 0;
}

// Mutable class without @immutable
class MutableData {
  final int value;
  MutableData(this.value);
}

class ShouldTriggerLint extends StatelessWidget {
  const ShouldTriggerLint({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<MyModel, MutableData>(
      // expect_lint: prefer_immutable_selector_value
      selector: (context, model) => MutableData(model.value),
      builder: (context, data, child) => Text('${data.value}'),
    );
  }
}
