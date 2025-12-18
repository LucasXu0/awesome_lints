// Note: This rule currently returns false as the Dart analyzer
// already handles deprecated usage warnings comprehensively.
// These tests are placeholders for potential future enhancements.

@deprecated
class SomeClass {}

class Example {
  @deprecated
  void oldMethod() {
    print('deprecated');
  }

  void newMethod() {
    print('use this instead');
  }
}

void examples() {
  // Would be flagged if fully implemented
  final instance = SomeClass();

  final example = Example();
  example.oldMethod();
}
