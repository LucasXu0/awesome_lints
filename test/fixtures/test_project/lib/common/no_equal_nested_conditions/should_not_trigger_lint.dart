void differentNestedCondition() {
  final value = 1;

  if (value == 1) {
    if (value == 2) {
      print('different nested');
    }
  }
}

void nestedWithDifferentVariable() {
  final x = 1;
  final y = 2;

  if (x == 1) {
    if (y == 2) {
      print('different variable');
    }
  }
}

void deeplyNestedDifferent() {
  final x = 10;

  if (x > 5) {
    if (x < 20) {
      if (x == 10) {
        print('all different conditions');
      }
    }
  }
}

void nestedComplexDifferent() {
  final x = 10;
  final y = 20;

  if (x > 5 && y < 30) {
    if (x > 5 && y < 25) {
      print('different complex nested');
    }
  }
}

void nestedNullCheckDifferent() {
  String? text;
}

void nestedMethodCallDifferent() {
  final list = [1, 2, 3];

  if (list.isEmpty) {
    if (list.length < 5) {
      print('different method call');
    }
  }
}

void simpleIfWithoutNesting() {
  final value = 1;

  if (value == 1) {
    print('no nesting');
  }
}

void separateIfStatements() {
  final value = 5;

  if (value == 5) {
    print('first if');
  }

  if (value == 5) {
    print('separate if, not nested');
  }
}

void nestedDifferentComparison() {
  final age = 25;

  if (age >= 18) {
    if (age < 65) {
      print('different comparison');
    }
  }
}

void nestedInversedCondition() {
  final flag = true;

  if (flag) {
    if (!flag) {
      print('inversed condition');
    }
  }
}

void nestedDifferentLogical() {
  final value = 10;

  if (value == 1 || value == 2) {
    if (value == 1 && value == 2) {
      print('different logical operator');
    }
  }
}

void nestedInElseDifferent() {
  final value = 10;

  if (value == 5) {
    print('outer');
  } else {
    if (value == 10) {
      print('different nested in else');
    }
  }
}

void multipleNestedAllDifferent() {
  final value = 42;

  if (value == 42) {
    if (value > 40) {
      print('first nested different');
    }
    if (value < 50) {
      print('second nested different');
    }
  }
}
