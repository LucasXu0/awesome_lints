// ignore_for_file: arguments_ordering, avoid_accessing_collections_by_constant_index, avoid_accessing_other_classes_private_members, avoid_adjacent_strings, avoid_always_null_parameters, avoid_assigning_to_static_field, avoid_assignments_as_conditions, avoid_async_call_in_sync_function, avoid_barrel_files, avoid_bitwise_operators_with_booleans, avoid_bottom_type_in_patterns, avoid_bottom_type_in_records, avoid_cascade_after_if_null, avoid_casting_to_extension_type, avoid_collapsible_if, avoid_collection_equality_checks, avoid_collection_methods_with_unrelated_types, avoid_collection_mutating_methods, avoid_commented_out_code, avoid_complex_arithmetic_expressions, avoid_complex_conditions, avoid_complex_loop_conditions, avoid_conditions_with_boolean_literals, avoid_constant_assert_conditions, avoid_constant_conditions, avoid_constant_switches, avoid_continue, avoid_contradictory_expressions, avoid_declaring_call_method, avoid_default_tostring, avoid_deprecated_usage, avoid_double_slash_imports, avoid_duplicate_cascades, avoid_duplicate_collection_elements, avoid_empty_setstate, avoid_late_context, avoid_missing_controller, avoid_mounted_in_setstate, avoid_non_null_assertion, avoid_single_child_column_or_row, avoid_stateless_widget_initialized_fields, avoid_undisposed_instances, avoid_unnecessary_gesture_detector, avoid_unnecessary_overrides_in_state, avoid_unnecessary_stateful_widgets, avoid_wrapping_in_padding, binary_expression_operand_order, dead_code, dispose_class_fields, dispose_fields, double_literal_format, newline_before_case, newline_before_constructor, newline_before_method, newline_before_return, no_empty_block, no_empty_string, no_equal_arguments, no_equal_conditions, no_equal_nested_conditions, no_equal_switch_case, no_equal_switch_expression_cases, no_equal_then_else, no_magic_number, no_magic_string, no_object_declaration, pass_existing_future_to_future_builder, pass_existing_stream_to_stream_builder, prefer_action_button_tooltip, prefer_align_over_container, prefer_async_callback, prefer_center_over_align, prefer_compute_over_isolate_run, prefer_constrained_box_over_container, prefer_container, prefer_dedicated_media_query_methods, prefer_for_loop_in_children, prefer_padding_over_container, prefer_single_setstate, prefer_sized_box_square, prefer_sliver_prefix, prefer_spacing, prefer_text_rich, prefer_void_callback, prefer_widget_private_members, proper_super_calls, unused_element, unused_import, unused_local_variable

class Test {
  void testProperContainsUsage() {
    final list = [1, 2, 3, 4, 5];

    // Using contains directly - this is good
    if (list.contains(1)) {
      print('found');
    }

    // Using negated contains - this is good
    if (!list.contains(2)) {
      print('not found');
    }

    // In variable assignment
    var found = list.contains(3);
    var notFound = !list.contains(4);

    // In return statement
    if (checkInList(list, 5)) {
      print('check');
    }

    // In while loop
    while (list.contains(6)) {
      break;
    }

    // In ternary expression
    var message = list.contains(7) ? 'found' : 'not found';
    var message2 = !list.contains(8) ? 'not found' : 'found';

    // Combined with logical operators
    if (list.contains(9) && list.length > 5) {
      print('found and long');
    }

    if (!list.contains(10) || list.isEmpty) {
      print('not found or empty');
    }
  }

  bool checkInList(List<int> list, int value) {
    return list.contains(value);
  }

  void testIndexOfForSpecificIndex() {
    final list = [1, 2, 3, 4, 5];

    // Checking for specific index (not -1) - this is OK
    if (list.indexOf(1) == 0) {
      print('at start');
    }

    if (list.indexOf(2) == 1) {
      print('at index 1');
    }

    if (list.indexOf(3) != 0) {
      print('not at start');
    }

    // Using indexOf to get the actual index
    var index = list.indexOf(4);
    if (index > 0) {
      print('found after start');
    }

    // Comparing indexOf results
    if (list.indexOf(5) > list.indexOf(3)) {
      print('5 comes after 3');
    }

    // Using indexOf for position-based logic
    var pos = list.indexOf(2);
    if (pos >= 0 && pos < 3) {
      print('in first three positions');
    }
  }

  void testStringContains() {
    final str = 'hello world';

    // Using contains directly - this is good
    if (str.contains('hello')) {
      print('found');
    }

    if (!str.contains('goodbye')) {
      print('not found');
    }

    // Using contains with pattern
    if (str.contains(RegExp(r'\d+'))) {
      print('has digits');
    }
  }

  void testOtherComparisons() {
    final list = [1, 2, 3];

    // Comparing with other values (not -1)
    if (list.length == 3) {
      print('has 3 elements');
    }

    // Other method comparisons
    if (list.first == 1) {
      print('first is 1');
    }

    if (list.last != 5) {
      print('last is not 5');
    }
  }

  void testIndexOfReturnValue() {
    final list = ['a', 'b', 'c'];

    // Using indexOf return value directly (not comparing)
    var index = list.indexOf('b');
    print('Index: $index');

    // Passing indexOf to function
    processIndex(list.indexOf('a'));

    // Using in expressions that don't compare with -1
    var doubled = list.indexOf('c') * 2;
    print(doubled);
  }

  void processIndex(int index) {
    print('Processing index: $index');
  }

  void testComplexExpressions() {
    final list = ['a', 'b', 'c'];

    // Using contains in method chain
    if (list.map((e) => e.toUpperCase()).toList().contains('A')) {
      print('found');
    }

    // In assert with contains
    assert(list.contains('a'));
    assert(!list.contains('d'));
  }
}
