// Switch statement with all return branches
String basicReturnSwitch(int value) {
  // expect_lint: prefer_switch_expression
  switch (value) {
    case 1:
      return 'one';
    case 2:
      return 'two';
    case 3:
      return 'three';
    default:
      return 'other';
  }
}

// Switch statement with assignment to same variable
void assignmentSwitch(String input) {
  String result;

  // expect_lint: prefer_switch_expression
  switch (input) {
    case 'a':
      result = 'Apple';
      break;
    case 'b':
      result = 'Banana';
      break;
    case 'c':
      result = 'Cherry';
      break;
  }

  print(result);
}

// Switch with all returns (different types)
int numericReturnSwitch(String value) {
  // expect_lint: prefer_switch_expression
  switch (value) {
    case 'zero':
      return 0;
    case 'one':
      return 1;
    case 'two':
      return 2;
    default:
      return -1;
  }
}

// Switch with assignment and default case
void assignmentWithDefault(int value) {
  var message = '';

  // expect_lint: prefer_switch_expression
  switch (value) {
    case 1:
      message = 'First';
      break;
    case 2:
      message = 'Second';
      break;
    default:
      message = 'Other';
      break;
  }

  print(message);
}

// Enum switch with returns
enum Color { red, green, blue }

String colorName(Color color) {
  // expect_lint: prefer_switch_expression
  switch (color) {
    case Color.red:
      return 'Red';
    case Color.green:
      return 'Green';
    case Color.blue:
      return 'Blue';
  }
}

// Switch with pattern matching on types (Dart 3.0+)
String describeValue(Object value) {
  // expect_lint: prefer_switch_expression
  switch (value) {
    case int():
      return 'Integer';
    case String():
      return 'Text';
    case bool():
      return 'Boolean';
    default:
      return 'Unknown';
  }
}

// Switch with simple calculation in each branch
int calculateScore(String grade) {
  // expect_lint: prefer_switch_expression
  switch (grade) {
    case 'A':
      return 100;
    case 'B':
      return 80;
    case 'C':
      return 60;
    case 'D':
      return 40;
    default:
      return 0;
  }
}

// Switch assigning boolean values
void booleanAssignment(int value) {
  bool isEven;

  // expect_lint: prefer_switch_expression
  switch (value % 2) {
    case 0:
      isEven = true;
      break;
    case 1:
      isEven = false;
      break;
  }

  print(isEven);
}

// Switch with nullable returns
String? nullableReturnSwitch(int value) {
  // expect_lint: prefer_switch_expression
  switch (value) {
    case 1:
      return 'one';
    case 2:
      return null;
    case 3:
      return 'three';
    default:
      return null;
  }
}

// Switch with complex expressions in return
double getPriceMultiplier(String membership) {
  // expect_lint: prefer_switch_expression
  switch (membership) {
    case 'gold':
      return 1.0;
    case 'silver':
      return 0.9;
    case 'bronze':
      return 0.8;
    default:
      return 0.5;
  }
}
