// ignore_for_file: dead_code

void switchWithNoSpacing() {
  final value = 1;
  switch (value) {
    case 1:
      print('one');
      break;
    // expect_lint: newline_before_case
    case 2:
      print('two');
      break;
    // expect_lint: newline_before_case
    case 3:
      print('three');
      break;
  }
}

void switchWithMultipleStatements() {
  final value = 'test';
  switch (value) {
    case 'a':
      print('first');
      print('statement');
      break;
    // expect_lint: newline_before_case
    case 'b':
      print('second');
      break;
  }
}

void switchWithBlocks() {
  final value = 1;
  switch (value) {
    case 1:
      {
        print('block one');
      }
    // expect_lint: newline_before_case
    case 2:
      {
        print('block two');
      }
  }
}

void nestedSwitch() {
  final outer = 1;
  switch (outer) {
    case 1:
      final inner = 2;
      switch (inner) {
        case 1:
          print('inner 1');
          break;
        // expect_lint: newline_before_case
        case 2:
          print('inner 2');
          break;
      }
      break;
    // expect_lint: newline_before_case
    case 2:
      print('outer 2');
      break;
  }
}

void switchWithDefault() {
  final value = 1;
  switch (value) {
    case 1:
      print('one');
      break;
    // expect_lint: newline_before_case
    case 2:
      print('two');
      break;
    // expect_lint: newline_before_case
    default:
      print('default');
  }
}

void switchWithReturn() {
  final value = 1;
  switch (value) {
    case 1:
      return;
    // expect_lint: newline_before_case
    case 2:
      return;
  }
}

String switchExpression(int value) {
  switch (value) {
    case 1:
      return 'one';
    // expect_lint: newline_before_case
    case 2:
      return 'two';
    // expect_lint: newline_before_case
    default:
      return 'other';
  }
}

void switchWithContinue() {
  final value = 1;
  switch (value) {
    case 1:
      print('one');
      break;
    // expect_lint: newline_before_case
    case 2:
      print('two');
      continue three;
    // expect_lint: newline_before_case
    three:
    case 3:
      print('three');
      break;
  }
}

void switchWithComplexStatements() {
  final value = 1;
  switch (value) {
    case 1:
      for (var i = 0; i < 10; i++) {
        print(i);
      }
      break;
    // expect_lint: newline_before_case
    case 2:
      if (value == 2) {
        print('two');
      }
      break;
  }
}
