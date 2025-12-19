// ignore_for_file: unused_local_variable, dead_code, no_empty_block

void functionWithNoBlankLineBeforeReturn() {
  final value = 42;
  // expect_lint: newline_before_return
  return;
}

String functionWithStatementBeforeReturn() {
  final name = 'test';
  // 
  return name;
}

int calculateValue() {
  final x = 10;
  final y = 20;
  return x + y;
}

void multipleStatements() {
  print('first');
  print('second');
  return;
}

void ifStatementWithReturn() {
  final value = 42;
  if (value > 10) {
    print('large');
    return;
  }
}

String conditionalReturn(bool condition) {
  if (condition) {
    final result = 'true';
    return result;
  }
  final defaultValue = 'false';
  return defaultValue;
}

void nestedBlocks() {
  for (var i = 0; i < 10; i++) {
    final value = i * 2;
    if (value > 5) {
      print(value);
      return;
    }
  }
}

int withLocalVariables() {
  final a = 1;
  final b = 2;
  final c = a + b;
  return c;
}

void withMethodCall() {
  print('Processing');
  return;
}

String assignmentBeforeReturn() {
  String result;
  result = 'value';
  return result;
}
