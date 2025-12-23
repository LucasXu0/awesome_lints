// Missing spacing between cases with statements
void missingSpacing() {
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

// Missing spacing with return statements
String missingSpacingWithReturns(int value) {
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

// Missing spacing with blocks
void missingSpacingWithBlocks() {
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

// Nested switch with missing spacing
void nestedSwitchMissingSpacing() {
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

// Multiple statements per case missing spacing
void multipleStatementsMissingSpacing() {
  final value = 1;
  switch (value) {
    case 1:
      print('first');
      print('statement');
      break;
    // expect_lint: newline_before_case
    case 2:
      print('second');
      print('case');
      break;
  }
}

// Complex indentation (deeply nested)
void deeplyNested() {
  if (true) {
    if (true) {
      final value = 1;
      switch (value) {
        case 1:
          print('one');
          break;
        // expect_lint: newline_before_case
        case 2:
          print('two');
          break;
      }
    }
  }
}

// Mixed with fallthrough cases
void mixedWithFallthrough() {
  final value = 1;
  switch (value) {
    case 1:
    case 2:
      print('one or two');
      break;
    // expect_lint: newline_before_case (this should trigger because previous case has statements)
    case 3:
      print('three');
      break;
  }
}

// Default case missing spacing
void defaultCaseMissingSpacing() {
  final value = 1;
  switch (value) {
    case 1:
      print('one');
      break;
    // expect_lint: newline_before_case
    default:
      print('default');
  }
}
