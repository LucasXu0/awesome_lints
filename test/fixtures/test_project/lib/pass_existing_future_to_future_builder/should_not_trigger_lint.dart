import 'package:flutter/widgets.dart';

// ignore_for_file: unused_local_variable, prefer_const_constructors, unused_field

class ShouldNotTriggerLint extends StatefulWidget {
  final Future<String>? future;

  const ShouldNotTriggerLint({super.key, this.future});

  @override
  State<ShouldNotTriggerLint> createState() => _ShouldNotTriggerLintState();
}

class _ShouldNotTriggerLintState extends State<ShouldNotTriggerLint> {
  late Future<String> _myFuture;

  @override
  void initState() {
    super.initState();
    // Properly initialize the future in initState
    _myFuture = _fetchData();
  }

  Future<String> _fetchData() async {
    await Future.delayed(Duration(seconds: 1));
    return 'data';
  }

  @override
  Widget build(BuildContext context) {
    // Case 1: Passing a field variable - should NOT trigger
    final widget1 = FutureBuilder<String>(
      future: _myFuture,
      builder: (context, snapshot) {
        return Text(snapshot.data ?? 'Loading...');
      },
    );

    // Case 2: Passing a widget property - should NOT trigger
    final widget2 = FutureBuilder<String>(
      future: widget.future,
      builder: (context, snapshot) {
        return Text(snapshot.data ?? 'Loading...');
      },
    );

    // Case 3: Passing null - should NOT trigger
    final widget3 = FutureBuilder<String>(
      future: null,
      builder: (context, snapshot) {
        return Text('No future');
      },
    );

    // Case 4: Passing a local variable - should NOT trigger
    final existingFuture = _myFuture;
    final widget4 = FutureBuilder<String>(
      future: existingFuture,
      builder: (context, snapshot) {
        return Text(snapshot.data ?? 'Loading...');
      },
    );

    return Container();
  }
}
