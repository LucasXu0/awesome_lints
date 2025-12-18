import 'package:flutter/widgets.dart';

// ignore_for_file: unused_local_variable, prefer_const_constructors, unused_field

class ShouldNotTriggerLint extends StatefulWidget {
  final Stream<String>? stream;

  const ShouldNotTriggerLint({super.key, this.stream});

  @override
  State<ShouldNotTriggerLint> createState() => _ShouldNotTriggerLintState();
}

class _ShouldNotTriggerLintState extends State<ShouldNotTriggerLint> {
  late Stream<String> _myStream;

  @override
  void initState() {
    super.initState();
    // Properly initialize the stream in initState
    _myStream = _fetchData();
  }

  Stream<String> _fetchData() {
    return Stream.periodic(Duration(seconds: 1), (i) => 'data $i');
  }

  @override
  Widget build(BuildContext context) {
    // Case 1: Passing a field variable - should NOT trigger
    final widget1 = StreamBuilder<String>(
      stream: _myStream,
      builder: (context, snapshot) {
        return Text(snapshot.data ?? 'Loading...');
      },
    );

    // Case 2: Passing a widget property - should NOT trigger
    final widget2 = StreamBuilder<String>(
      stream: widget.stream,
      builder: (context, snapshot) {
        return Text(snapshot.data ?? 'Loading...');
      },
    );

    // Case 3: Passing null - should NOT trigger
    final widget3 = StreamBuilder<String>(
      stream: null,
      builder: (context, snapshot) {
        return Text('No stream');
      },
    );

    // Case 4: Passing a local variable - should NOT trigger
    final existingStream = _myStream;
    final widget4 = StreamBuilder<String>(
      stream: existingStream,
      builder: (context, snapshot) {
        return Text(snapshot.data ?? 'Loading...');
      },
    );

    return Container();
  }
}
