// Already using switch expression (Dart 3.0+)
String alreadySwitchExpression(int value) {
  return switch (value) {
    1 => 'one',
    2 => 'two',
    3 => 'three',
    _ => 'other',
  };
}

// Switch with side effects (can't be converted)
void switchWithSideEffects(int value) {
  switch (value) {
    case 1:
      print('Processing one');
      print('Done');
      break;
    case 2:
      print('Processing two');
      print('Done');
      break;
    default:
      print('Processing other');
      break;
  }
}

// Switch with mixed return and non-return
String mixedReturnBehavior(int value) {
  switch (value) {
    case 1:
      return 'one';
    case 2:
      print('two');
      break;
    case 3:
      return 'three';
    default:
      break;
  }
  return 'default';
}

// Switch with assignment to different variables
void differentAssignmentTargets(int value) {
  var first = '';
  var second = '';

  switch (value) {
    case 1:
      first = 'one';
      break;
    case 2:
      second = 'two';
      break;
    default:
      first = 'other';
      break;
  }

  print('$first $second');
}

// Switch with fall-through cases
void switchWithFallThrough(String input) {
  switch (input) {
    case 'a':
    case 'b':
      print('a or b');
      break;
    case 'c':
      print('c');
      break;
  }
}

// Switch with no return value
void voidReturnSwitch(int value) {
  switch (value) {
    case 1:
      return;
    case 2:
      return;
    default:
      return;
  }
}

// Switch with multiple statements per case
void multipleStatementsPerCase(int value) {
  var result = 0;

  switch (value) {
    case 1:
      final temp = value * 2;
      result = temp + 1;
      break;
    case 2:
      final temp = value * 3;
      result = temp + 2;
      break;
    default:
      result = value;
      break;
  }

  print(result);
}

// Switch with conditional logic inside
String conditionalInsideSwitch(int value) {
  switch (value) {
    case 1:
      if (value > 0) {
        return 'positive one';
      } else {
        return 'negative one';
      }
    case 2:
      return 'two';
    default:
      return 'other';
  }
}

// Switch with try-catch
void switchWithTryCatch(int value) {
  switch (value) {
    case 1:
      try {
        print('Attempting one');
      } catch (e) {
        print('Error: $e');
      }
      break;
    case 2:
      print('two');
      break;
  }
}

// Empty switch statement
void emptySwitch(int value) {
  switch (value) {}
}

// Switch with only one case
void singleCaseSwitch(int value) {
  switch (value) {
    case 1:
      print('only one');
      break;
  }
}

// Switch performing assignments with side effects
void assignmentWithSideEffects(int value) {
  var result = '';

  switch (value) {
    case 1:
      result = getValue1();
      break;
    case 2:
      result = getValue2();
      break;
  }

  print(result);
}

String getValue1() {
  print('Getting value 1');
  return 'one';
}

String getValue2() {
  print('Getting value 2');
  return 'two';
}

// Switch with break without assignment
void breakWithoutAssignment(int value) {
  switch (value) {
    case 1:
      break;
    case 2:
      break;
    default:
      break;
  }
}

// Switch with continue to label
void switchWithContinue(int value) {
  myLoop:
  for (var i = 0; i < 5; i++) {
    switch (value) {
      case 1:
        continue myLoop;
      case 2:
        break;
      default:
        continue myLoop;
    }
  }
}

// Switch with throw statements (not all branches)
String switchWithThrow(int value) {
  switch (value) {
    case 1:
      return 'one';
    case 2:
      throw Exception('Invalid value');
    case 3:
      return 'three';
    default:
      return 'other';
  }
}

// Switch with variable declarations but no assignment/return
void switchWithOnlyDeclarations(int value) {
  switch (value) {
    case 1:
      final x = 1;
      print(x);
      break;
    case 2:
      final y = 2;
      print(y);
      break;
  }
}
