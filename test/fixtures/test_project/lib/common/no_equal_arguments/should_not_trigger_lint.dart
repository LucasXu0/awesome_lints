// ignore_for_file: arguments_ordering, avoid_accessing_collections_by_constant_index, avoid_accessing_other_classes_private_members, avoid_adjacent_strings, avoid_always_null_parameters, avoid_assigning_to_static_field, avoid_assignments_as_conditions, avoid_async_call_in_sync_function, avoid_barrel_files, avoid_bitwise_operators_with_booleans, avoid_bottom_type_in_patterns, avoid_bottom_type_in_records, avoid_cascade_after_if_null, avoid_casting_to_extension_type, avoid_collapsible_if, avoid_collection_equality_checks, avoid_collection_methods_with_unrelated_types, avoid_collection_mutating_methods, avoid_commented_out_code, avoid_complex_arithmetic_expressions, avoid_complex_conditions, avoid_complex_loop_conditions, avoid_conditions_with_boolean_literals, avoid_constant_assert_conditions, avoid_constant_conditions, avoid_constant_switches, avoid_continue, avoid_contradictory_expressions, avoid_declaring_call_method, avoid_default_tostring, avoid_deprecated_usage, avoid_double_slash_imports, avoid_duplicate_cascades, avoid_duplicate_collection_elements, avoid_empty_setstate, avoid_late_context, avoid_missing_controller, avoid_mounted_in_setstate, avoid_non_null_assertion, avoid_single_child_column_or_row, avoid_stateless_widget_initialized_fields, avoid_undisposed_instances, avoid_unnecessary_gesture_detector, avoid_unnecessary_overrides_in_state, avoid_unnecessary_stateful_widgets, avoid_wrapping_in_padding, binary_expression_operand_order, dead_code, dispose_class_fields, dispose_fields, double_literal_format, newline_before_case, newline_before_constructor, newline_before_method, newline_before_return, no_boolean_literal_compare, no_empty_block, no_empty_string, no_equal_conditions, no_equal_nested_conditions, no_equal_switch_case, no_equal_switch_expression_cases, no_equal_then_else, no_magic_number, no_magic_string, no_object_declaration, pass_existing_future_to_future_builder, pass_existing_stream_to_stream_builder, prefer_action_button_tooltip, prefer_align_over_container, prefer_async_await, prefer_async_callback, prefer_center_over_align, prefer_compute_over_isolate_run, prefer_constrained_box_over_container, prefer_container, prefer_contains, prefer_correct_for_loop_increment, prefer_dedicated_media_query_methods, prefer_early_return, prefer_for_loop_in_children, prefer_iterable_of, prefer_named_boolean_parameters, prefer_padding_over_container, prefer_single_setstate, prefer_sized_box_square, prefer_sliver_prefix, prefer_spacing, prefer_switch_expression, prefer_text_rich, prefer_void_callback, prefer_widget_private_members, proper_super_calls, unused_element, unused_import, unused_local_variable

class User {
  final String firstName;
  final String lastName;
  final String email;
  final int age;

  User(this.firstName, this.lastName, this.email, this.age);

  User.named({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.age,
  });
}

class Test {
  // Different variables in constructor
  void testConstructor() {
    var firstName = 'John';
    var lastName = 'Doe';
    var email = 'john@example.com';

    var user1 = User(firstName, lastName, email, 30);
    var user2 = User('Jane', 'Smith', 'jane@example.com', 25);
  }

  // Different variables in named constructor
  void testNamedConstructor() {
    var firstName = 'John';
    var lastName = 'Doe';

    var user = User.named(
      firstName: firstName,
      lastName: lastName,
      email: 'john@example.com',
      age: 30,
    );
  }

  // Different variables in function call
  void testFunctionCall() {
    var firstName = 'John';
    var lastName = 'Doe';

    var fullName = getFullName(firstName, lastName);
    var result = calculate(5, 10, 15);
  }

  // Different property access
  void testPropertyAccess() {
    var user = User('John', 'Doe', 'john@example.com', 30);

    compare(user.firstName, user.lastName);
    processData(user.firstName, user.email, user.age);
  }

  // Different method calls
  void testMethodCall() {
    compare(getValue(), getOtherValue());
    processThree(compute(), calculate2(), 10);
  }

  // Different values in list methods
  void testListMethods() {
    var list = <int>[];
    list.fillRange(0, 10, 5);

    var items = <String>[];
    combine('hello', 'world');
  }

  // Different keys in map methods
  void testMapMethods() {
    var map = <String, String>{};
    map.putIfAbsent('key1', () => 'value1');
  }

  // Different values in math operations
  void testMathOperations() {
    var x = 10;
    var y = 20;

    var result = max(x, y);
    var min = minimum(x, y, 30);
  }

  // Different complex expressions
  void testComplexExpressions() {
    var list1 = [1, 2, 3];
    var list2 = [4, 5, 6];

    compare(list1.first, list2.first);
    var result = calculate(list1.length, list2.length, 5);
  }

  // Different in nested calls
  void testNestedCalls() {
    var value1 = 'test';
    var value2 = 'other';

    outer(value1, value2, inner(1, 2));
  }

  // Different getter calls
  void testGetters() {
    var obj1 = MyClass();
    var obj2 = MyClass();

    compare(obj1.value, obj2.value);
  }

  // Single argument (no comparison needed)
  void testSingleArgument() {
    print('hello');
    var user = SingleArgConstructor('John');
  }

  // Identical literal numbers (acceptable)
  void testLiterals() {
    var result1 = calculate(1, 2, 3);
    var result2 = max(5, 10);
    compare('hello', 'world');
  }

  String getValue() => 'value';

  String getOtherValue() => 'other';

  int compute() => 42;

  int calculate2() => 100;
}

String getFullName(String first, String last) => '$first $last';

void compare(dynamic a, dynamic b) {}

void processData(String a, String b, int c) {}

void processThree(int a, int b, int c) {}

void combine(String a, String b) {}

int max(int a, int b) => a > b ? a : b;

int minimum(int a, int b, int c) => a;

int calculate(int a, int b, int c) => a + b + c;

void outer(String a, String b, int c) {}

int inner(int a, int b) => a + b;

class MyClass {
  int get value => 42;
}

class SingleArgConstructor {
  final String value;

  SingleArgConstructor(this.value);
}

// Top-level function with different arguments
void topLevel() {
  var x = 10;
  var y = 20;
  compare(x, y);
}

// In callback with different values
void testCallback() {
  var items = [1, 2, 3];
  items.fold(0, (prev, element) => prev + element);
}

// Chain method calls with different arguments
void testChaining() {
  var str = 'hello';
  str.replaceAll('l', 'r');
}

// Zero arguments
void testNoArguments() {
  noArgs();
}

void noArgs() {}

// Repeated literal values (allowed since they're literals)
void testRepeatedLiterals() {
  var point = Point(0, 0);
  var rect = Rectangle(0, 0, 100, 100);
}

class Point {
  final int x;
  final int y;

  Point(this.x, this.y);
}

class Rectangle {
  final int x;
  final int y;
  final int width;
  final int height;

  Rectangle(this.x, this.y, this.width, this.height);
}

// Different variable names with same value (should not trigger)
void testDifferentVariables() {
  var value1 = 'test';
  var value2 = 'test';
  // These are different variables, even though they have the same value
  // The source code is different: value1 vs value2
  compare(value1, value2);
}
