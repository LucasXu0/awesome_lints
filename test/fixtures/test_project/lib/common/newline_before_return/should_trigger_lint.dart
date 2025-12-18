// ignore_for_file: unused_local_variable, dead_code

void functionWithNoBlankLineBeforeReturn() {
  final value = 42;
  // expect_lint: newline_before_return
  return;
}

String functionWithStatementBeforeReturn() {
  final name = 'test';
  // expect_lint: newline_before_return
  return name;
}

int calculateValue() {
  final x = 10;
  final y = 20;
  // expect_lint: newline_before_return
  return x + y;
}

void multipleStatements() {
  print('first');
  print('second');
  // expect_lint: newline_before_return
  return;
}

void ifStatementWithReturn() {
  final value = 42;
  if (value > 10) {
    print('large');
    // expect_lint: newline_before_return
    return;
  }
}

String conditionalReturn(bool condition) {
  if (condition) {
    final result = 'true';
    // expect_lint: newline_before_return
    return result;
  }
  final defaultValue = 'false';
  // expect_lint: newline_before_return
  return defaultValue;
}

void nestedBlocks() {
  for (var i = 0; i < 10; i++) {
    final value = i * 2;
    if (value > 5) {
      print(value);
      // expect_lint: newline_before_return
      return;
    }
  }
}

int withLocalVariables() {
  final a = 1;
  final b = 2;
  final c = a + b;
  // expect_lint: newline_before_return
  return c;
}

void withMethodCall() {
  print('Processing');
  // expect_lint: newline_before_return
  return;
}

String assignmentBeforeReturn() {
  String result;
  result = 'value';
  // expect_lint: newline_before_return
  return result;
}
