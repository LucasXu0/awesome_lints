// Test cases that should trigger the prefer-named-boolean-parameters lint

// Positional boolean parameter in function
// expect_lint: prefer_named_boolean_parameters
void someFunction(String name, bool isExternal, bool isTemporary) {}

// Positional boolean parameter in method
class Example {
  // expect_lint: prefer_named_boolean_parameters
  void doSomething(String name, bool isExternal, bool isTemporary) {}

  // expect_lint: prefer_named_boolean_parameters
  bool checkCondition(int value, bool strict) {
    return strict && value > 0;
  }
}

// Single positional boolean parameter
// expect_lint: prefer_named_boolean_parameters
void singleBoolParam(bool flag) {}

// Multiple positional parameters including booleans
// expect_lint: prefer_named_boolean_parameters
void mixedParams(String name, bool isActive, int count) {}

// Constructor with positional boolean parameters (with explicit types)
class Widget {
  final bool visible;
  final bool enabled;

  // expect_lint: prefer_named_boolean_parameters
  Widget(bool this.visible, bool this.enabled);
}

// Function with optional positional boolean
// expect_lint: prefer_named_boolean_parameters
void optionalPositionalBool(String name, [bool isActive = false]) {}

void test() {
  // These are the call sites that would be unclear
  someFunction('test', true, false); // unclear what true/false mean

  Example().doSomething('test', true, false);
  Example().checkCondition(5, true);

  singleBoolParam(true);

  mixedParams('test', true, 10);

  Widget(true, false);

  optionalPositionalBool('test', true);
}
