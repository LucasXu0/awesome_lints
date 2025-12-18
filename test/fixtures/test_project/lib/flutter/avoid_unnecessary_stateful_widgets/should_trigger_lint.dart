import 'package:flutter/widgets.dart';

class UnnecessaryStateful extends StatefulWidget {
  const UnnecessaryStateful({super.key});

  @override
  State<UnnecessaryStateful> createState() => _UnnecessaryStatefulState();
}

// expect_lint: avoid_unnecessary_stateful_widgets
class _UnnecessaryStatefulState extends State<UnnecessaryStateful> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
