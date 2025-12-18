class WannabeFunction {
  String calculate(String a, String b, String c) => '$a $b $c!';
}

class Calculator {
  int add(int a, int b) => a + b;
}

class Greeter {
  String greet() => 'Hello!';
}

void goodUsage() {
  var wf = WannabeFunction();
  var out = wf.calculate('Hi', 'there,', 'gang');
  print(out);

  var calc = Calculator();
  var result = calc.add(5, 3);
  print(result);

  var greeter = Greeter();
  print(greeter.greet());
}
