// ignore_for_file: arguments_ordering, avoid_accessing_collections_by_constant_index, avoid_accessing_other_classes_private_members, avoid_adjacent_strings, avoid_always_null_parameters, avoid_assigning_to_static_field, avoid_assignments_as_conditions, avoid_async_call_in_sync_function, avoid_barrel_files, avoid_bitwise_operators_with_booleans, avoid_bottom_type_in_patterns, avoid_bottom_type_in_records, avoid_cascade_after_if_null, avoid_casting_to_extension_type, avoid_collapsible_if, avoid_collection_equality_checks, avoid_collection_methods_with_unrelated_types, avoid_collection_mutating_methods, avoid_commented_out_code, avoid_complex_arithmetic_expressions, avoid_complex_conditions, avoid_complex_loop_conditions, avoid_conditions_with_boolean_literals, avoid_constant_assert_conditions, avoid_constant_conditions, avoid_constant_switches, avoid_continue, avoid_contradictory_expressions, avoid_declaring_call_method, avoid_default_tostring, avoid_deprecated_usage, avoid_double_slash_imports, avoid_duplicate_cascades, avoid_duplicate_collection_elements, avoid_empty_setstate, avoid_late_context, avoid_missing_controller, avoid_mounted_in_setstate, avoid_non_null_assertion, avoid_single_child_column_or_row, avoid_stateless_widget_initialized_fields, avoid_undisposed_instances, avoid_unnecessary_gesture_detector, avoid_unnecessary_overrides_in_state, avoid_unnecessary_stateful_widgets, avoid_wrapping_in_padding, binary_expression_operand_order, dead_code, dispose_class_fields, dispose_fields, double_literal_format, newline_before_case, newline_before_constructor, newline_before_method, newline_before_return, no_boolean_literal_compare, no_empty_block, no_empty_string, no_equal_conditions, no_equal_nested_conditions, no_equal_switch_case, no_equal_switch_expression_cases, no_equal_then_else, no_magic_number, no_magic_string, no_object_declaration, pass_existing_future_to_future_builder, pass_existing_stream_to_stream_builder, prefer_action_button_tooltip, prefer_align_over_container, prefer_async_callback, prefer_center_over_align, prefer_compute_over_isolate_run, prefer_constrained_box_over_container, prefer_container, prefer_dedicated_media_query_methods, prefer_for_loop_in_children, prefer_padding_over_container, prefer_single_setstate, prefer_sized_box_square, prefer_sliver_prefix, prefer_spacing, prefer_text_rich, prefer_void_callback, prefer_widget_private_members, proper_super_calls, unused_element, unused_import, unused_local_variable

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
  // Duplicate variable in constructor
  void testConstructor() {
    var firstName = 'John';
    var lastName = 'Doe';

    // expect_lint: no_equal_arguments
    var user1 = User(firstName, firstName, 'john@example.com', 30);

    var user2 = User('Jane', 'Jane', 'jane@example.com', 25);
  }

  // Duplicate variable in named constructor
  void testNamedConstructor() {
    var firstName = 'John';

    // expect_lint: no_equal_arguments
    var user = User.named(
      firstName: firstName,
      lastName: firstName,
      email: 'john@example.com',
      age: 30,
    );
  }

  // Duplicate variable in function call
  void testFunctionCall() {
    var firstName = 'John';

    // expect_lint: no_equal_arguments
    var fullName = getFullName(firstName, firstName);

    var result = calculate(5, 5, 10);
  }

  // Duplicate property access
  void testPropertyAccess() {
    var user = User('John', 'Doe', 'john@example.com', 30);

    // expect_lint: no_equal_arguments
    compare(user.firstName, user.firstName);

    // expect_lint: no_equal_arguments
    processData(user.email, user.email, user.age);
  }

  // Duplicate method call
  void testMethodCall() {
    // expect_lint: no_equal_arguments
    compare(getValue(), getValue());

    // expect_lint: no_equal_arguments
    processThree(compute(), compute(), 10);
  }

  // Duplicate in list methods
  void testListMethods() {
    var list = <int>[];
    var value = 5;

    list.fillRange(0, 10, value);

    var items = <String>[];
    var item = 'hello';
    // expect_lint: no_equal_arguments
    combine(item, item);
  }

  // Duplicate in map methods
  void testMapMethods() {
    var map = <String, String>{};
    var key = 'key1';

    map.putIfAbsent(key, () => key);
  }

  // Duplicate in math operations
  void testMathOperations() {
    var x = 10;

    // expect_lint: no_equal_arguments
    var result = max(x, x);

    // expect_lint: no_equal_arguments
    var min = minimum(x, x, x);
  }

  // Duplicate complex expressions
  void testComplexExpressions() {
    var list = [1, 2, 3];

    // expect_lint: no_equal_arguments
    compare(list.first, list.first);

    // expect_lint: no_equal_arguments
    var result = calculate(list.length, list.length, 5);
  }

  // Duplicate in nested calls
  void testNestedCalls() {
    var value = 'test';

    // expect_lint: no_equal_arguments
    outer(value, value, inner(1, 2));
  }

  // Duplicate getter calls
  void testGetters() {
    var obj = MyClass();

    // expect_lint: no_equal_arguments
    compare(obj.value, obj.value);
  }

  String getValue() => 'value';

  int compute() => 42;
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

// Top-level function with duplicate arguments
void topLevel() {
  var x = 10;
  // expect_lint: no_equal_arguments
  compare(x, x);
}

// In callback
void testCallback() {
  var items = [1, 2, 3];
  var value = 5;

  items.fold(value, (prev, element) => prev + value);
}

// Chain method calls with duplicates
void testChaining() {
  var str = 'hello';

  // expect_lint: no_equal_arguments
  str.replaceAll(str, str);
}
