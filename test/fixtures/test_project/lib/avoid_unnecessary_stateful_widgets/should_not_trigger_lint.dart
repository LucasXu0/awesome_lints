// ignore_for_file: unused_element

import 'package:flutter/widgets.dart';

class NecessaryStateful extends StatefulWidget {
  const NecessaryStateful({super.key});

  @override
  State<NecessaryStateful> createState() => _NecessaryStatefulState();
}

class _NecessaryStatefulState extends State<NecessaryStateful> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text('$_counter');
  }
}

class LifecycleStateful extends StatefulWidget {
  const LifecycleStateful({super.key});

  @override
  State<LifecycleStateful> createState() => _LifecycleStatefulState();
}

class _LifecycleStatefulState extends State<LifecycleStateful> {
  @override
  void initState() {
    super.initState();
    print('Init');
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
