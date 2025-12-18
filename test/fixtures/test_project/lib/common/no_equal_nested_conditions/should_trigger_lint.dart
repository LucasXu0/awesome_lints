// ignore_for_file: dead_code, unused_local_variable

void basicNestedDuplicate() {
  final value = 1;

  // expect_lint: no_equal_nested_conditions
  if (value == 1) {
    if (value == 1) {
      print('duplicate nested');
    }
  }
}

void nestedWithOtherStatements() {
  final value = 5;

  // expect_lint: no_equal_nested_conditions
  if (value == 5) {
    print('outer');
    if (value == 5) {
      print('duplicate nested with statements');
    }
  }
}

void deeplyNestedDuplicate() {
  final x = 10;

  // expect_lint: no_equal_nested_conditions
  if (x > 5) {
    print('first level');
    if (x < 20) {
      print('second level');
      if (x > 5) {
        print('deeply nested duplicate');
      }
    }
  }
}

void nestedComplexCondition() {
  final x = 10;
  final y = 20;

  // expect_lint: no_equal_nested_conditions
  if (x > 5 && y < 30) {
    print('outer');
    if (x > 5 && y < 30) {
      print('nested duplicate complex');
    }
  }
}

void nestedNullCheck() {
  String? text;
}

void nestedWithMethodCall() {
  final list = [1, 2, 3];

  // expect_lint: no_equal_nested_conditions
  if (list.isEmpty) {
    if (list.isEmpty) {
      print('nested duplicate method call');
    }
  }
}

void nestedInElseBranch() {
  final value = 10;

  // expect_lint: no_equal_nested_conditions
  if (value == 5) {
    print('outer');
  } else {
    if (value == 5) {
      print('nested in else with duplicate');
    }
  }
}

void multipleNestedDuplicates() {
  final value = 42;

  // expect_lint: no_equal_nested_conditions
  if (value == 42) {
    if (value == 42) {
      print('first nested duplicate');
    }
    if (value == 42) {
      print('second nested duplicate');
    }
  }
}

void nestedNegation() {
  final flag = true;

  // expect_lint: no_equal_nested_conditions
  if (!flag) {
    if (!flag) {
      print('nested duplicate negation');
    }
  }
}

void nestedLogicalOr() {
  final value = 10;

  // expect_lint: no_equal_nested_conditions
  if (value == 1 || value == 2) {
    if (value == 1 || value == 2) {
      print('nested duplicate logical or');
    }
  }
}

void nestedComparison() {
  final age = 25;

  // expect_lint: no_equal_nested_conditions
  if (age >= 18) {
    print('adult');
    if (age >= 18) {
      print('nested duplicate comparison');
    }
  }
}

void nestedInBlock() {
  final value = 7;

  // expect_lint: no_equal_nested_conditions
  if (value == 7) {
    {
      if (value == 7) {
        print('nested in block');
      }
    }
  }
}
