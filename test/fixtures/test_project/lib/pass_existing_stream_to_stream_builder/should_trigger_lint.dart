import 'package:flutter/widgets.dart';

// ignore_for_file: unused_local_variable, prefer_const_constructors

class ShouldTriggerLint extends StatefulWidget {
  const ShouldTriggerLint({super.key});

  @override
  State<ShouldTriggerLint> createState() => _ShouldTriggerLintState();
}

// expect_lint: avoid_unnecessary_stateful_widgets
class _ShouldTriggerLintState extends State<ShouldTriggerLint> {
  // ignore: prefer_widget_private_members
  Stream<String> getValue() {
    return Stream.fromIterable(['1', '2', '3']);
  }

  @override
  Widget build(BuildContext context) {
    // Case 1: Method invocation creating stream inline - should trigger
    // expect_lint: pass_existing_stream_to_stream_builder
    final widget1 = StreamBuilder<String>(
      stream: getValue(),
      builder: (context, snapshot) {
        return Text(snapshot.data ?? 'Loading...');
      },
    );

    // Case 2: Stream.periodic creating stream inline - should trigger
    // expect_lint: pass_existing_stream_to_stream_builder
    final widget2 = StreamBuilder<int>(
      stream: Stream.periodic(Duration(seconds: 1), (i) => i),
      builder: (context, snapshot) {
        return Text(snapshot.data?.toString() ?? 'Loading...');
      },
    );

    // Case 3: Stream.value creating stream inline - should trigger
    // expect_lint: pass_existing_stream_to_stream_builder
    final widget3 = StreamBuilder<String>(
      stream: Stream.value('hello'),
      builder: (context, snapshot) {
        return Text(snapshot.data ?? 'Loading...');
      },
    );

    // Case 4: Stream.fromIterable creating stream inline - should trigger
    // expect_lint: pass_existing_stream_to_stream_builder
    final widget4 = StreamBuilder<String>(
      stream: Stream.fromIterable(['a', 'b', 'c']),
      builder: (context, snapshot) {
        return Text(snapshot.data ?? 'Loading...');
      },
    );

    // Case 5: Instance method call creating stream inline - should trigger
    // expect_lint: pass_existing_stream_to_stream_builder
    final widget5 = StreamBuilder<String>(
      stream: _fetchData(),
      builder: (context, snapshot) {
        return Text(snapshot.data ?? 'Loading...');
      },
    );

    return Container();
  }

  Stream<String> _fetchData() {
    return Stream.periodic(Duration(seconds: 1), (i) => 'data $i');
  }
}
