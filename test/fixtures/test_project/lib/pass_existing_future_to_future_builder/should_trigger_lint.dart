import 'package:flutter/widgets.dart';

// ignore_for_file: unused_local_variable, prefer_const_constructors

class ShouldTriggerLint extends StatefulWidget {
  const ShouldTriggerLint({super.key});

  @override
  State<ShouldTriggerLint> createState() => _ShouldTriggerLintState();
}

// expect_lint: avoid_unnecessary_stateful_widgets
class _ShouldTriggerLintState extends State<ShouldTriggerLint> {
  Future<String> getValue() async {
    return 'value';
  }

  @override
  Widget build(BuildContext context) {
    // Case 1: Method invocation creating future inline - should trigger
    // expect_lint: pass_existing_future_to_future_builder
    final widget1 = FutureBuilder<String>(
      future: getValue(),
      builder: (context, snapshot) {
        return Text(snapshot.data ?? 'Loading...');
      },
    );

    // Case 2: Future.delayed creating future inline - should trigger
    // expect_lint: pass_existing_future_to_future_builder
    final widget2 = FutureBuilder<int>(
      future: Future.delayed(Duration(seconds: 1), () => 42),
      builder: (context, snapshot) {
        return Text(snapshot.data?.toString() ?? 'Loading...');
      },
    );

    // Case 3: Future.value creating future inline - should trigger
    // expect_lint: pass_existing_future_to_future_builder
    final widget3 = FutureBuilder<String>(
      future: Future.value('hello'),
      builder: (context, snapshot) {
        return Text(snapshot.data ?? 'Loading...');
      },
    );

    // Case 4: Static method call creating future inline - should trigger
    // expect_lint: pass_existing_future_to_future_builder
    final widget4 = FutureBuilder<String>(
      future: Future.microtask(() => 'test'),
      builder: (context, snapshot) {
        return Text(snapshot.data ?? 'Loading...');
      },
    );

    // Case 5: Instance method call creating future inline - should trigger
    // expect_lint: pass_existing_future_to_future_builder
    final widget5 = FutureBuilder<String>(
      future: _fetchData(),
      builder: (context, snapshot) {
        return Text(snapshot.data ?? 'Loading...');
      },
    );

    return Container();
  }

  Future<String> _fetchData() async {
    await Future.delayed(Duration(seconds: 1));
    return 'data';
  }
}
