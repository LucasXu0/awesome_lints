import 'package:flutter/material.dart';

// ignore_for_file: unused_field, prefer_const_constructors, prefer_dedicated_media_query_methods

class ShouldTriggerLint extends StatefulWidget {
  const ShouldTriggerLint({super.key});

  @override
  State<ShouldTriggerLint> createState() => _ShouldTriggerLintState();
}

class _ShouldTriggerLintState extends State<ShouldTriggerLint> {
  // Case 1: Direct context usage in late field - should trigger
  // expect_lint: avoid_late_context
  late final _theme = Theme.of(context);

  // Case 2: Context in method call within late field - should trigger
  // expect_lint: avoid_late_context
  late final _mediaQuery = MediaQuery.of(context);

  // Case 3: Context in custom method call - should trigger
  // expect_lint: avoid_late_context
  late final _customValue = _createValue(context);

  // Case 4: Context nested in expression - should trigger
  // expect_lint: avoid_late_context
  late final _textStyle = Theme.of(context).textTheme.bodyLarge;

  // Case 5: Context in complex expression - should trigger
  // expect_lint: avoid_late_context
  late final _width = MediaQuery.of(context).size.width > 600 ? 200.0 : 100.0;

  String _createValue(BuildContext context) {
    return 'value';
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
