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
  // ignore: unused_local_variable, deprecated_member_use_from_same_package
  final instance = SomeClass();

  final example = Example();
  // ignore: deprecated_member_use_from_same_package
  example.oldMethod();
}
