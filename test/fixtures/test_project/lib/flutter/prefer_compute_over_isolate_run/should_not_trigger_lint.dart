import 'dart:isolate' as isolate;

import 'package:flutter/foundation.dart';

// ignore_for_file: unused_element, unused_local_variable

// Case 1: Using compute() - should NOT trigger
int _computeFunction(int value) {
  int sum = 0;
  for (int i = 0; i < value; i++) {
    sum += i;
  }
  return sum;
}

Future<int> useCompute() async {
  final result = await compute(_computeFunction, 1000000);
  return result;
}

// Case 2: Using compute() with anonymous function - should NOT trigger
Future<String> useComputeWithClosure() async {
  final result = await compute((String message) {
    return message.toUpperCase();
  }, 'hello world');
  return result;
}

// Case 3: Other Isolate methods (not run) - should NOT trigger
Future<void> useOtherIsolateMethods() async {
  final receivePort = isolate.ReceivePort();
  await isolate.Isolate.spawn(_isolateEntry, receivePort.sendPort);

  final currentIsolate = isolate.Isolate.current;

  // Using exit, not run
  isolate.Isolate.exit();
}

void _isolateEntry(isolate.SendPort sendPort) {
  sendPort.send('Hello from isolate');
}

// Case 4: Method named 'run' but not on Isolate class - should NOT trigger
class MyRunner {
  Future<int> run() async {
    return 42;
  }
}

Future<void> useCustomRun() async {
  final runner = MyRunner();
  await runner.run();
}

// Case 5: Variable named Isolate - should NOT trigger
class Isolate {
  Future<void> run() async {
    // Custom run method
  }
}

Future<void> useCustomIsolate() async {
  final isolate = Isolate();
  await isolate.run();
}

// Case 6: Using compute from foundation library - should NOT trigger
Future<List<int>> useComputeWithList() async {
  final result = await compute((int count) {
    return List.generate(count, (i) => i * 2);
  }, 100);
  return result;
}

// Case 7: Just referencing Isolate class - should NOT trigger
void referenceIsolateClass() {
  final type = Isolate;
  // Not actually calling run()
}
