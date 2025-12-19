// ignore_for_file: arguments_ordering, avoid_accessing_collections_by_constant_index, avoid_accessing_other_classes_private_members, avoid_adjacent_strings, avoid_always_null_parameters, avoid_assigning_to_static_field, avoid_assignments_as_conditions, avoid_async_call_in_sync_function, avoid_barrel_files, avoid_bitwise_operators_with_booleans, avoid_bottom_type_in_patterns, avoid_bottom_type_in_records, avoid_cascade_after_if_null, avoid_casting_to_extension_type, avoid_collapsible_if, avoid_collection_equality_checks, avoid_collection_methods_with_unrelated_types, avoid_collection_mutating_methods, avoid_commented_out_code, avoid_complex_arithmetic_expressions, avoid_complex_conditions, avoid_complex_loop_conditions, avoid_conditions_with_boolean_literals, avoid_constant_assert_conditions, avoid_constant_conditions, avoid_constant_switches, avoid_continue, avoid_contradictory_expressions, avoid_declaring_call_method, avoid_default_tostring, avoid_deprecated_usage, avoid_double_slash_imports, avoid_duplicate_cascades, avoid_duplicate_collection_elements, avoid_empty_setstate, avoid_late_context, avoid_missing_controller, avoid_mounted_in_setstate, avoid_non_null_assertion, avoid_single_child_column_or_row, avoid_stateless_widget_initialized_fields, avoid_undisposed_instances, avoid_unnecessary_gesture_detector, avoid_unnecessary_overrides_in_state, avoid_unnecessary_stateful_widgets, avoid_wrapping_in_padding, binary_expression_operand_order, dead_code, dispose_class_fields, dispose_fields, double_literal_format, newline_before_case, newline_before_constructor, newline_before_method, newline_before_return, no_boolean_literal_compare, no_empty_block, no_equal_arguments, no_equal_conditions, no_equal_nested_conditions, no_equal_switch_case, no_equal_switch_expression_cases, no_equal_then_else, no_magic_number, no_magic_string, no_object_declaration, pass_existing_future_to_future_builder, pass_existing_stream_to_stream_builder, prefer_action_button_tooltip, prefer_align_over_container, prefer_async_await, prefer_async_callback, prefer_center_over_align, prefer_compute_over_isolate_run, prefer_constrained_box_over_container, prefer_container, prefer_contains, prefer_correct_for_loop_increment, prefer_dedicated_media_query_methods, prefer_early_return, prefer_for_loop_in_children, prefer_iterable_of, prefer_named_boolean_parameters, prefer_padding_over_container, prefer_single_setstate, prefer_sized_box_square, prefer_sliver_prefix, prefer_spacing, prefer_switch_expression, prefer_text_rich, prefer_void_callback, prefer_widget_private_members, proper_super_calls, unused_element, unused_import, unused_local_variable

class Test {
  // Non-empty strings in variable assignment
  void testVariables() {
    var value = 'hello';
    String message = 'world';
    final greeting = 'Hi there';
  }

  // Non-empty strings in function calls
  void testFunctionCalls() {
    print('Hello, World!');
    Uri.https('example.com');
  }

  // Non-empty strings in method calls
  void testMethodCalls() {
    var list = <String>[];
    list.add('item');

    var map = <String, String>{};
    map['key'] = 'value';
  }

  // Proper empty check using isEmpty
  void testComparisons(String input) {
    if (input.isEmpty) {
      print('empty');
    }

    if (input.isNotEmpty) {
      print('not empty');
    }

    var isEmpty = input.isEmpty;
  }

  // Non-empty strings in ternary
  void testTernary(bool condition) {
    var result = condition ? 'yes' : 'no';
    var result2 = condition ? 'value1' : 'value2';
  }

  // Non-empty strings in collections
  void testCollections() {
    var list = ['hello', 'world'];
    var map = {'key': 'value'};
    var set = {'hello', 'world'};
  }

  // Non-empty string in return
  String testReturn(bool condition) {
    if (condition) {
      return 'success';
    }

    return 'failure';
  }

  // Non-empty field initializer
  String field = 'default value';
  final String finalField = 'constant';

  // Non-empty default parameter
  Test({String name = 'default'});

  void withDefault([String value = 'default']) {
    print(value);
  }

  void withNamed({String value = 'default'}) {
    print(value);
  }

  // Proper string concatenation
  void testConcatenation() {
    var firstName = 'John';
    var lastName = 'Doe';
    var fullName = firstName + ' ' + lastName;
    var greeting = firstName + 'Hello, ';
  }

  // Using isEmpty in assert
  void testAssert() {
    var value = 'test';
    assert(value.isNotEmpty);
  }

  // Non-empty case in switch
  void testSwitch(String value) {
    switch (value) {
      case 'option1':
        print('first option');
        break;

      case 'option2':
        print('second option');
        break;

      default:
        print('default');
    }
  }
}

// Top-level constants with values
const appName = 'My App';
const version = '1.0.0';

// Top-level variables with values
var userName = 'John';
var userEmail = 'john@example.com';

// Function returning non-empty string
String getMessage() {
  return 'Hello, World!';
}

// Expression body with value
String getGreeting() => 'Hi there!';

// Null coalescing with non-empty default
void testNullCoalescing(String? value) {
  var result = value ?? 'default value';
}

// String interpolation without empty strings
void testInterpolation() {
  var name = 'John';
  var age = 30;
  var message = 'Name: $name, Age: $age';
  var greeting = 'Hello, $name!';
}

// Using const for empty string when it's a valid use case
class Config {
  static const String emptyPlaceholder = 'A';

  void useConstant(String input) {
    // Using a named constant is acceptable
    if (input == Config.emptyPlaceholder) {
      print('matches empty placeholder');
    }
  }
}

// Multi-line strings
void multilineStrings() {
  var text = '''
This is a multi-line
string with content.
''';

  var code = '''
void function() {
  print('hello');
}
''';
}

// Raw strings
void rawStrings() {
  var pattern = r'\d+';
  var path = r'C:\Users\Documents';
}
