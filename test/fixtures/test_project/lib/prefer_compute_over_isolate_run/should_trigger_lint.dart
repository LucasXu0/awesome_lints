import 'dart:isolate';
import 'dart:isolate' as dart_isolate;

// ignore_for_file: unused_element, unused_local_variable

// Case 1: Basic Isolate.run() call - should trigger
Future<int> computeHeavyTask() async {
  // expect_lint: prefer_compute_over_isolate_run
  final result = await Isolate.run(() {
    int sum = 0;
    for (int i = 0; i < 1000000; i++) {
      sum += i;
    }
    return sum;
  });
  return result;
}

// Case 2: Isolate.run() with a named function - should trigger
int _heavyComputation() {
  int sum = 0;
  for (int i = 0; i < 1000000; i++) {
    sum += i;
  }
  return sum;
}

Future<int> computeWithNamedFunction() async {
  // expect_lint: prefer_compute_over_isolate_run
  final result = await Isolate.run(_heavyComputation);
  return result;
}

// Case 3: Prefixed import usage - should trigger
Future<String> computeWithPrefix() async {
  // expect_lint: prefer_compute_over_isolate_run
  final result = await dart_isolate.Isolate.run(() {
    return 'computed result';
  });
  return result;
}

// Case 4: Isolate.run() in a callback - should trigger
void setupCallbacks() {
  final callback = () async {
    // expect_lint: prefer_compute_over_isolate_run
    await Isolate.run(() => 42);
  };
}

// Case 5: Isolate.run() with type parameter - should trigger
Future<List<int>> computeList() async {
  // expect_lint: prefer_compute_over_isolate_run
  final result = await Isolate.run<List<int>>(() {
    return List.generate(100, (i) => i * 2);
  });
  return result;
}
