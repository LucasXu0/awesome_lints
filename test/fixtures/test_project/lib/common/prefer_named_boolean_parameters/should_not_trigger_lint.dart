// Test cases that should NOT trigger the prefer-named-boolean-parameters lint

// Named boolean parameters - this is the recommended approach
void goodFunction(
  String name, {
  required bool isExternal,
  required bool isTemporary,
}) {}

// Optional named boolean parameters
void optionalNamedParams(
  String name, {
  bool isActive = false,
  bool isValid = true,
}) {}

// Method with named boolean parameters
class Example {
  void doSomething(
    String name, {
    required bool isExternal,
    required bool isTemporary,
  }) {}

  bool checkCondition(int value, {bool strict = false}) {
    return strict && value > 0;
  }
}

// Constructor with named boolean parameters
class Widget {
  final bool visible;
  final bool enabled;

  Widget({required this.visible, required this.enabled});
}

// Positional non-boolean parameters are fine
void nonBooleanParams(String name, int age, double height) {}

// Only non-boolean positional parameters
void mixedNonBool(String name, int count, {bool isValid = false}) {}

// Getter that returns bool - not a parameter
bool get isActive => true;

// Function with no parameters
void noParams() {}

// Function with only String parameters
void onlyStrings(String first, String second) {}

void test() {
  // Clear at call site what the parameters mean
  goodFunction('test', isExternal: true, isTemporary: false);

  optionalNamedParams('test', isActive: true);

  Example().doSomething('test', isExternal: true, isTemporary: false);
  Example().checkCondition(5, strict: true);

  Widget(visible: true, enabled: false);

  nonBooleanParams('test', 25, 180.0);

  mixedNonBool('test', 10, isValid: true);

  noParams();
  onlyStrings('hello', 'world');
}
