// ignore_for_file: unused_field

// Test cases that should NOT trigger the prefer_early_return lint

// ignore_for_file: arguments_ordering, avoid_accessing_collections_by_constant_index, avoid_accessing_other_classes_private_members, avoid_adjacent_strings, avoid_always_null_parameters, avoid_assigning_to_static_field, avoid_assignments_as_conditions, avoid_async_call_in_sync_function, avoid_barrel_files, avoid_bitwise_operators_with_booleans, avoid_bottom_type_in_patterns, avoid_bottom_type_in_records, avoid_cascade_after_if_null, avoid_casting_to_extension_type, avoid_collapsible_if, avoid_collection_equality_checks, avoid_collection_methods_with_unrelated_types, avoid_collection_mutating_methods, avoid_commented_out_code, avoid_complex_arithmetic_expressions, avoid_complex_conditions, avoid_complex_loop_conditions, avoid_conditions_with_boolean_literals, avoid_constant_assert_conditions, avoid_constant_conditions, avoid_constant_switches, avoid_continue, avoid_contradictory_expressions, avoid_declaring_call_method, avoid_default_tostring, avoid_deprecated_usage, avoid_double_slash_imports, avoid_duplicate_cascades, avoid_duplicate_collection_elements, avoid_empty_setstate, avoid_late_context, avoid_missing_controller, avoid_mounted_in_setstate, avoid_non_null_assertion, avoid_single_child_column_or_row, avoid_stateless_widget_initialized_fields, avoid_undisposed_instances, avoid_unnecessary_gesture_detector, avoid_unnecessary_overrides_in_state, avoid_unnecessary_stateful_widgets, avoid_wrapping_in_padding, binary_expression_operand_order, dead_code, dispose_class_fields, dispose_fields, double_literal_format, newline_before_case, newline_before_constructor, newline_before_method, newline_before_return, no_boolean_literal_compare, no_empty_block, no_empty_string, no_equal_arguments, no_equal_conditions, no_equal_nested_conditions, no_equal_switch_case, no_equal_switch_expression_cases, no_equal_then_else, no_magic_number, no_magic_string, no_object_declaration, pass_existing_future_to_future_builder, pass_existing_stream_to_stream_builder, prefer_action_button_tooltip, prefer_align_over_container, prefer_async_callback, prefer_center_over_align, prefer_compute_over_isolate_run, prefer_constrained_box_over_container, prefer_container, prefer_dedicated_media_query_methods, prefer_for_loop_in_children, prefer_named_boolean_parameters, prefer_padding_over_container, prefer_return_await, prefer_single_setstate, prefer_sized_box_square, prefer_sliver_prefix, prefer_spacing, prefer_switch_expression, prefer_text_rich, prefer_void_callback, prefer_widget_private_members, proper_super_calls, unused_element, unused_import, unused_local_variable

// Valid: If statement with else clause
void processItem(String? item) {
  if (item != null) {
    print('Processing: $item');
  } else {
    print('No item to process');
  }
}

// Valid: Multiple statements in function body
void validateInput(int value) {
  print('Validating...');
  if (value > 0) {
    print('Valid value');
  }
}

// Valid: Already using early return pattern
void checkValue(String? value) {
  if (value == null) {
    return;
  }
  print('Processing: $value');
}

// Valid: If statement is not the only statement
void handleData(List<int> data) {
  final count = data.length;
  if (count > 0) {
    print('Has $count items');
  }
  print('Done');
}

// Valid: Multiple if statements
void multipleChecks(int a, int b) {
  if (a > 0) {
    print('a is positive');
  }
  if (b > 0) {
    print('b is positive');
  }
}

// Valid: Empty function
void emptyFunction() {}

// Valid: Function with only return statement
int getValue() {
  return 42;
}

// Valid: Function with if-else chain
void checkStatus(int status) {
  if (status == 0) {
    print('Pending');
  } else if (status == 1) {
    print('Active');
  } else {
    print('Done');
  }
}

// Valid: Function with switch statement
void handleEvent(String event) {
  switch (event) {
    case 'start':
      print('Starting');
      break;
    case 'stop':
      print('Stopping');
      break;
  }
}

// Valid: Function with try-catch
void riskyOperation() {
  try {
    print('Attempting operation');
  } catch (e) {
    print('Error: $e');
  }
}

// Valid: Function with for loop
void printNumbers(int count) {
  for (var i = 0; i < count; i++) {
    print(i);
  }
}

// Valid: Function with while loop
void countdown(int n) {
  while (n > 0) {
    print(n);
    n--;
  }
}

// Valid: Expression-bodied function
int double(int x) => x * 2;

// Valid: Function with variable declaration and usage
void processData(String data) {
  final trimmed = data.trim();
  print('Processed: $trimmed');
}

// Valid: Function with multiple early returns
String? findItem(List<String> items, String target) {
  if (items.isEmpty) {
    return null;
  }

  if (!items.contains(target)) {
    return null;
  }

  return target;
}

// Valid: Nested if with outer code
void validateRange(int value) {
  print('Checking range...');
  if (value >= 0) {
    if (value <= 100) {
      print('In range');
    }
  }
  print('Check complete');
}

// Valid: If statement with else-if
void categorize(int score) {
  if (score >= 90) {
    print('A');
  } else if (score >= 80) {
    print('B');
  }
}

// Valid: Function that returns void with statements after if
void notify(bool shouldNotify) {
  if (shouldNotify) {
    print('Notification sent');
  }
  print('Function completed');
}

// Valid: Class with constructor (not a regular function body)
class Example {
  Example() {
    print('Constructor called');
  }
}

// Valid: Getter that doesn't wrap entire body in if
class DataHolder {
  String? _data;

  String get data {
    return _data ?? 'default';
  }
}

// Valid: Setter with multiple statements
class Config {
  String _value = '';

  set value(String newValue) {
    _value = newValue;
    print('Value updated');
  }
}
