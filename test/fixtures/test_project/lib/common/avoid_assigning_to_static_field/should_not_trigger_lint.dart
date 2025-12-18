// Test cases that should NOT trigger the avoid-assigning-to-static-field lint

class MyClass {
  static int staticValue = 1;
  int instanceValue = 1;

  static void staticMethod() {
    // Static method can modify static field
    staticValue = 2;
    staticValue++;
  }

  void instanceMethod() {
    // Modifying instance field is OK
    instanceValue = 2;
    instanceValue++;
  }
}

class OtherClass {
  static int value = 0;

  static void work() {
    // Static method modifying its own static field
    value = 5;
  }
}

void topLevelFunction() {
  // Top-level function modifying static field
  MyClass.staticValue = 100;
}
