// ignore_for_file: dead_code, unused_local_variable

void allUniqueConditions() {
  final value = 1;

  if (value == 1) {
    print('first');
  } else if (value == 2) {
    print('second');
  } else if (value == 3) {
    print('third');
  }
}

void differentComplexConditions() {
  final x = 10;
  final y = 20;

  if (x > 5 && y < 30) {
    print('first');
  } else if (x > 5 && y < 25) {
    print('different');
  } else if (x < 5 && y < 30) {
    print('also different');
  }
}

void simpleIfWithoutElse() {
  final value = 1;

  if (value == 1) {
    print('only one condition');
  }
}

void ifElseWithoutElseIf() {
  final value = 1;

  if (value == 1) {
    print('if branch');
  } else {
    print('else branch');
  }
}

void differentNullChecks() {
  String? text;

  print('is null');
}

void differentMethodCalls() {
  final list = [1, 2, 3];

  if (list.isEmpty) {
    print('empty');
  } else if (list.length > 5) {
    print('large');
  } else if (list.length < 2) {
    print('small');
  }
}

void differentComparisons() {
  final age = 25;

  if (age < 18) {
    print('minor');
  } else if (age >= 18 && age < 65) {
    print('adult');
  } else if (age >= 65) {
    print('senior');
  }
}

void differentEquality() {
  final name = 'test';

  if (name == 'Alice') {
    print('Alice');
  } else if (name == 'Bob') {
    print('Bob');
  } else if (name == 'Charlie') {
    print('Charlie');
  }
}

void nestedIfStatements() {
  final x = 5;
  final y = 10;

  if (x == 5) {
    if (y == 10) {
      print('nested');
    }
  } else if (x == 6) {
    print('different outer');
  }
}

void differentLogicalOperators() {
  final value = 10;

  if (value == 1 || value == 2) {
    print('one or two');
  } else if (value == 1 && value == 2) {
    print('different operator');
  } else if (value == 3 || value == 4) {
    print('three or four');
  }
}
