// ignore_for_file: dead_code, unused_local_variable

void basicDuplicateCondition() {
  final value = 1;

  if (value == 1) {
    print('first');
  } else if (value == 2) {
    print('second');
    // expect_lint: no_equal_conditions
  } else if (value == 1) {
    print('duplicate');
  }
}

void multipleDuplicates() {
  final value = 5;

  if (value == 1) {
    print('first');
  } else if (value == 2) {
    print('second');
    // expect_lint: no_equal_conditions
  } else if (value == 1) {
    print('first duplicate');
    // expect_lint: no_equal_conditions
  } else if (value == 2) {
    print('second duplicate');
  }
}

void duplicateComplexCondition() {
  final x = 10;
  final y = 20;

  if (x > 5 && y < 30) {
    print('first');
  } else if (x < 15) {
    print('second');
    // expect_lint: no_equal_conditions
  } else if (x > 5 && y < 30) {
    print('duplicate complex');
  }
}

void duplicateWithNegation() {
  final value = true;

  if (!value) {
    print('first');
  } else if (value) {
    print('second');
    // expect_lint: no_equal_conditions
  } else if (!value) {
    print('duplicate negation');
  }
}

void duplicateWithMethodCall() {
  final list = [1, 2, 3];

  if (list.isEmpty) {
    print('empty');
  } else if (list.length > 5) {
    print('large');
    // expect_lint: no_equal_conditions
  } else if (list.isEmpty) {
    print('duplicate empty check');
  }
}

void duplicateInLongChain() {
  final value = 42;

  if (value == 1) {
    print('one');
  } else if (value == 2) {
    print('two');
  } else if (value == 3) {
    print('three');
  } else if (value == 4) {
    print('four');
    // expect_lint: no_equal_conditions
  } else if (value == 2) {
    print('duplicate two');
  }
}

void duplicateEquality() {
  final name = 'test';

  if (name == 'Alice') {
    print('Alice');
  } else if (name == 'Bob') {
    print('Bob');
    // expect_lint: no_equal_conditions
  } else if (name == 'Alice') {
    print('duplicate Alice');
  }
}

void duplicateComparison() {
  final age = 25;

  if (age < 18) {
    print('minor');
  } else if (age >= 65) {
    print('senior');
    // expect_lint: no_equal_conditions
  } else if (age < 18) {
    print('duplicate minor check');
  }
}

void duplicateLogicalOr() {
  final value = 10;

  if (value == 1 || value == 2) {
    print('one or two');
  } else if (value == 3) {
    print('three');
    // expect_lint: no_equal_conditions
  } else if (value == 1 || value == 2) {
    print('duplicate or condition');
  }
}
