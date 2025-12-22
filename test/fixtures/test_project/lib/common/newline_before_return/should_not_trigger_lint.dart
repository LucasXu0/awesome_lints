// Return as first statement - no lint needed
void earlyReturn() {
  return;
}

// Return immediately after condition - no lint needed
String immediateReturnInBlock() {
  return 'value';
}

// Proper blank line before return
void withBlankLine() {
  final value = 42;

  return;
}

// Proper spacing with multiple statements
String properSpacing() {
  final name = 'test';
  final upper = name.toUpperCase();

  return upper;
}

// Multiple returns with proper spacing
int conditionalReturns(int value) {
  if (value < 0) {
    return 0;
  }

  if (value > 100) {
    return 100;
  }

  return value;
}

// Only statement in block
void singleStatementBlock() {
  if (true) {
    return;
  }
}

// Proper spacing in nested blocks
void nestedBlocksProper() {
  for (var i = 0; i < 10; i++) {
    final value = i * 2;

    if (value > 5) {
      print(value);

      return;
    }
  }
}

// Expression body - no block, no lint
String expressionBody() => 'value';

// Proper spacing with method calls
void methodCallWithSpacing() {
  print('Processing');
  print('Done');

  return;
}

// Return after multiple blank lines (still OK)
int multipleBlankLines() {
  final x = 10;

  return x;
}

// Switch statement with returns
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

// Try-catch with proper spacing
void tryCatchWithReturn() {
  try {
    final result = 42;

    return;
  } catch (e) {
    print(e);

    return;
  }
}
