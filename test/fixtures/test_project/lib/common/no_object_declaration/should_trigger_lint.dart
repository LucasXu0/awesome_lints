class Test {
  // Field with Object type
  // expect_lint: no_object_declaration
  Object data = 1;

  // Another field with Object type
  // expect_lint: no_object_declaration
  Object value = 'string';

  // Field with complex initialization
  // expect_lint: no_object_declaration
  Object complexData = {'key': 'value'};

  // Getter with Object return type
  // expect_lint: no_object_declaration
  Object get getter => 1;

  // Another getter with Object return type
  // expect_lint: no_object_declaration
  Object get dataGetter => data;

  // Method with Object return type
  // expect_lint: no_object_declaration
  Object doWork() {
    return 'result';
  }

  // Method with Object return type and parameters
  // expect_lint: no_object_declaration
  Object process(String input) {
    return input.length;
  }

  // Method returning Object with complex logic
  // expect_lint: no_object_declaration
  Object compute() {
    if (data is int) {
      return (data as int) * 2;
    }

    return 0;
  }
}

class Repository {
  // Field with Object type
  // expect_lint: no_object_declaration
  Object cache = {};

  // Getter with Object return type
  // expect_lint: no_object_declaration
  Object get data => cache;

  // Method with Object return type
  // expect_lint: no_object_declaration
  Object fetch(String id) {
    return cache;
  }
}

class GenericContainer {
  // Multiple fields with Object type
  // expect_lint: no_object_declaration
  Object item1 = 1;

  // expect_lint: no_object_declaration
  Object item2 = 'string';

  // expect_lint: no_object_declaration
  Object item3 = [1, 2, 3];

  // Method with Object return type
  // expect_lint: no_object_declaration
  Object getItem(int index) {
    switch (index) {
      case 0:
        return item1;

      case 1:
        return item2;

      case 2:
        return item3;

      default:
        return item1;
    }
  }
}
