// ignore_for_file: dead_code

void switchWithNoSpacing() {
  final value = 1;
  switch (value) {
    case 1:
      print('one');
      break;
    case 2:
      print('two');
      break;
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
        case 2:
          print('inner 2');
          break;
      }
      break;
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
    case 2:
      print('two');
      break;
    default:
      print('default');
  }
}

void switchWithReturn() {
  final value = 1;
  switch (value) {
    case 1:
      return;
    case 2:
      return;
  }
}

String switchExpression(int value) {
  switch (value) {
    case 1:
      return 'one';
    case 2:
      return 'two';
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
    case 2:
      print('two');
      continue three;
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
    case 2:
      if (value == 2) {
        print('two');
      }
      break;
  }
}
