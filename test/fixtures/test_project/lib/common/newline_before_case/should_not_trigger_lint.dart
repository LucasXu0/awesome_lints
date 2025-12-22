// First case doesn't need spacing
void firstCaseNoLint() {
  final value = 1;
  switch (value) {
    case 1:
      print('one');
      break;
  }
}

// Proper spacing between cases
void properSpacing() {
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

// Fallthrough cases (no statements) don't need spacing
void fallthroughCases() {
  final value = 1;
  switch (value) {
    case 1:
    case 2:
    case 3:
      print('one, two, or three');
      break;

    case 4:
    case 5:
      print('four or five');
      break;
  }
}

// Mixed fallthrough and regular cases
void mixedCases() {
  final value = 1;
  switch (value) {
    case 1:
    case 2:
      print('one or two');
      break;

    case 3:
      print('three');
      break;

    case 4:
    case 5:
    case 6:
      print('four, five, or six');
      break;
  }
}

// Single case switch
void singleCase() {
  final value = 1;
  switch (value) {
    case 1:
      print('only one');
      break;
  }
}

// Proper spacing with blocks
void blocksWithSpacing() {
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

// Proper spacing with default
void withDefaultProperSpacing() {
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

// Return statements with proper spacing
String switchWithReturns(int value) {
  switch (value) {
    case 1:
      return 'one';

    case 2:
      return 'two';

    default:
      return 'other';
  }
}

// Nested switch with proper spacing
void nestedSwitchProper() {
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

// Multiple statements per case with proper spacing
void multipleStatementsProper() {
  final value = 1;
  switch (value) {
    case 1:
      print('first');
      print('statement');
      break;

    case 2:
      print('second');
      print('case');
      break;
  }
}

// Complex control flow with proper spacing
void complexControlFlow() {
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

    case 3:
      while (value < 10) {
        print(value);
        break;
      }
      break;
  }
}

// Empty switch (no cases)
void emptySwitch() {
  final value = 1;
  switch (value) {}
}

// Fallthrough to case with statements
void fallthroughToStatements() {
  final value = 1;
  switch (value) {
    case 1:
    case 2:
      print('one or two');
      break;

    case 3:
      print('three');
      break;
  }
}
