import 'package:flutter/widgets.dart';

// ignore_for_file: unused_field, prefer_const_constructors

class ShouldNotTriggerLint extends StatefulWidget {
  const ShouldNotTriggerLint({super.key});

  @override
  State<ShouldNotTriggerLint> createState() => _ShouldNotTriggerLintState();
}

class _ShouldNotTriggerLintState extends State<ShouldNotTriggerLint> {
  // Case 1: Late field without context - should NOT trigger
  late final _value = _getValue();

  // Case 2: Late field with constant - should NOT trigger
  late final _constant = 'constant value';

  // Case 3: Late field without initializer - should NOT trigger
  late final String _noInit;

  // Case 4: Non-late field with context - should NOT trigger
  final _nonLateContext = null;

  // Case 5: Late field with other identifier named 'context' - should NOT trigger
  // (This is a variable named context, not BuildContext)
  late final _otherContext = _getContext();

  String _getValue() {
    return 'value';
  }

  String _getContext() {
    return 'not a BuildContext';
  }

  @override
  void initState() {
    super.initState();
    _noInit = 'initialized in initState';
  }

  @override
  Widget build(BuildContext context) {
    // Using context in build is fine
    final theme = Theme.of(context);
    return Container();
  }
}

// Case 6: Late field with context in non-State class - should NOT trigger
class NotAStateClass {
  late final _value = _create();

  String _create() {
    return 'value';
  }
}
