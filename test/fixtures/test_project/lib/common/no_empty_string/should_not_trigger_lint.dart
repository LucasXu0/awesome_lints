// ignore_for_file: arguments_ordering,avoid_accessing_collections_by_constant_index,avoid_accessing_other_classes_private_members,avoid_adjacent_strings,avoid_always_null_parameters,avoid_assigning_to_static_field,avoid_assignments_as_conditions,avoid_async_call_in_sync_function,avoid_async_callback_in_fake_async,avoid_barrel_files,avoid_bitwise_operators_with_booleans,avoid_bloc_public_fields,avoid_bloc_public_methods,avoid_bottom_type_in_patterns,avoid_bottom_type_in_records,avoid_cascade_after_if_null,avoid_casting_to_extension_type,avoid_collapsible_if,avoid_collection_equality_checks,avoid_collection_methods_with_unrelated_types,avoid_collection_mutating_methods,avoid_commented_out_code,avoid_complex_arithmetic_expressions,avoid_complex_conditions,avoid_complex_loop_conditions,avoid_conditions_with_boolean_literals,avoid_constant_assert_conditions,avoid_constant_conditions,avoid_constant_switches,avoid_continue,avoid_contradictory_expressions,avoid_cubits,avoid_declaring_call_method,avoid_default_tostring,avoid_deprecated_usage,avoid_double_slash_imports,avoid_duplicate_bloc_event_handlers,avoid_duplicate_cascades,avoid_duplicate_collection_elements,avoid_empty_build_when,avoid_empty_setstate,avoid_existing_instances_in_bloc_provider,avoid_instantiating_in_bloc_value_provider,avoid_instantiating_in_value_provider,avoid_late_context,avoid_missing_controller,avoid_mounted_in_setstate,avoid_non_null_assertion,avoid_passing_bloc_to_bloc,avoid_passing_build_context_to_blocs,avoid_read_inside_build,avoid_returning_value_from_cubit_methods,avoid_single_child_column_or_row,avoid_stateless_widget_initialized_fields,avoid_undisposed_instances,avoid_unnecessary_gesture_detector,avoid_unnecessary_overrides_in_state,avoid_unnecessary_stateful_widgets,avoid_watch_outside_build,avoid_wrapping_in_padding,binary_expression_operand_order,check_is_not_closed_after_async_gap,constant_pattern_never_matches_value_type,dead_code,deprecated_member_use,dispose_class_fields,dispose_fields,dispose_providers,double_literal_format,duplicate_ignore,emit_new_bloc_state_instances,equal_elements_in_set,handle_bloc_event_subclasses,must_call_super,newline_before_case,newline_before_constructor,newline_before_method,newline_before_return,no_boolean_literal_compare,no_empty_block,no_equal_arguments,no_equal_conditions,no_equal_nested_conditions,no_equal_switch_case,no_equal_switch_expression_cases,no_equal_then_else,no_object_declaration,non_exhaustive_switch_expression,not_assigned_potentially_non_nullable_local_variable,pass_existing_future_to_future_builder,pass_existing_stream_to_stream_builder,prefer_action_button_tooltip,prefer_align_over_container,prefer_async_await,prefer_async_callback,prefer_bloc_event_suffix,prefer_bloc_extensions,prefer_bloc_state_suffix,prefer_center_over_align,prefer_compute_over_isolate_run,prefer_constrained_box_over_container,prefer_container,prefer_contains,prefer_correct_bloc_provider,prefer_correct_for_loop_increment,prefer_correct_json_casts,prefer_dedicated_media_query_methods,prefer_early_return,prefer_first,prefer_for_loop_in_children,prefer_immutable_bloc_events,prefer_immutable_bloc_state,prefer_immutable_selector_value,prefer_iterable_of,prefer_last,prefer_multi_bloc_provider,prefer_multi_provider,prefer_named_boolean_parameters,prefer_nullable_provider_types,prefer_padding_over_container,prefer_provider_extensions,prefer_return_await,prefer_sealed_bloc_events,prefer_sealed_bloc_state,prefer_single_setstate,prefer_sized_box_square,prefer_sliver_prefix,prefer_spacing,prefer_switch_expression,prefer_text_rich,prefer_void_callback,prefer_widget_private_members,proper_super_calls,unchecked_use_of_nullable_value,unnecessary_null_comparison,unused_element,unused_field,unused_import,unused_local_variable

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
