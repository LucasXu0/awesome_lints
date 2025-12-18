class WannabeFunction {
  // expect_lint: avoid_declaring_call_method
  String call(String a, String b, String c) => '$a $b $c!';
}

class Calculator {
  // expect_lint: avoid_declaring_call_method
  int call(int a, int b) => a + b;
}

class Greeter {
  // expect_lint: avoid_declaring_call_method
  String call() => 'Hello!';
}

void badUsage() {
  var wf = WannabeFunction();
  var out = wf('Hi', 'there,', 'gang');
  print(out);

  var calc = Calculator();
  var result = calc(5, 3);
  print(result);
}
