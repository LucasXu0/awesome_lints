// ignore_for_file: arguments_ordering, avoid_accessing_collections_by_constant_index, avoid_accessing_other_classes_private_members, avoid_adjacent_strings, avoid_always_null_parameters, avoid_assigning_to_static_field, avoid_assignments_as_conditions, avoid_async_call_in_sync_function, avoid_barrel_files, avoid_bitwise_operators_with_booleans, avoid_bottom_type_in_patterns, avoid_bottom_type_in_records, avoid_cascade_after_if_null, avoid_casting_to_extension_type, avoid_collapsible_if, avoid_collection_equality_checks, avoid_collection_methods_with_unrelated_types, avoid_collection_mutating_methods, avoid_commented_out_code, avoid_complex_arithmetic_expressions, avoid_complex_conditions, avoid_complex_loop_conditions, avoid_conditions_with_boolean_literals, avoid_constant_assert_conditions, avoid_constant_conditions, avoid_constant_switches, avoid_continue, avoid_contradictory_expressions, avoid_declaring_call_method, avoid_default_tostring, avoid_deprecated_usage, avoid_double_slash_imports, avoid_duplicate_cascades, avoid_duplicate_collection_elements, avoid_empty_setstate, avoid_late_context, avoid_missing_controller, avoid_mounted_in_setstate, avoid_non_null_assertion, avoid_single_child_column_or_row, avoid_stateless_widget_initialized_fields, avoid_undisposed_instances, avoid_unnecessary_gesture_detector, avoid_unnecessary_overrides_in_state, avoid_unnecessary_stateful_widgets, avoid_wrapping_in_padding, binary_expression_operand_order, dead_code, dispose_class_fields, dispose_fields, double_literal_format, newline_before_case, newline_before_constructor, newline_before_method, newline_before_return, no_boolean_literal_compare, no_empty_block, no_empty_string, no_equal_arguments, no_equal_conditions, no_equal_nested_conditions, no_equal_switch_case, no_equal_switch_expression_cases, no_magic_number, no_magic_string, no_object_declaration, pass_existing_future_to_future_builder, pass_existing_stream_to_stream_builder, prefer_action_button_tooltip, prefer_align_over_container, prefer_async_await, prefer_async_callback, prefer_center_over_align, prefer_compute_over_isolate_run, prefer_constrained_box_over_container, prefer_container, prefer_contains, prefer_correct_for_loop_increment, prefer_dedicated_media_query_methods, prefer_early_return, prefer_for_loop_in_children, prefer_iterable_of, prefer_named_boolean_parameters, prefer_padding_over_container, prefer_single_setstate, prefer_sized_box_square, prefer_sliver_prefix, prefer_spacing, prefer_switch_expression, prefer_text_rich, prefer_void_callback, prefer_widget_private_members, proper_super_calls, unused_element, unused_import, unused_local_variable

class Test {
  void testIfStatement() {
    bool condition = true;
    String result;

    // If-else with different branches
    if (condition) {
      result = 'true';
    } else {
      result = 'false';
    }

    // If-else with different statements
    if (condition) {
      print('hello');
      result = 'value1';
    } else {
      print('goodbye');
      result = 'value2';
    }

    // If without else
    if (condition) {
      result = 'value';
    }

    // If-else-if chain (not checked)
    if (condition) {
      result = 'first';
    } else if (!condition) {
      result = 'second';
    } else {
      result = 'third';
    }

    // Different method calls
    if (condition) {
      print('message1');
    } else {
      print('message2');
    }
  }

  String testReturnStatements(bool condition) {
    // Different return values
    if (condition) {
      return 'true';
    } else {
      return 'false';
    }
  }

  void testConditionalExpression() {
    bool condition = true;

    // Ternary with different values
    final result = condition ? 'true' : 'false';

    // Ternary with different numbers
    final number = condition ? 42 : 0;

    // Ternary with different variable references
    String value1 = 'test1';
    String value2 = 'test2';
    final result2 = condition ? value1 : value2;

    // Ternary with different method calls
    final result3 = condition ? getValue1() : getValue2();

    // Ternary with different expressions
    int x = 5;
    final result4 = condition ? x + 10 : x + 20;
  }

  String getValue1() => 'value1';

  String getValue2() => 'value2';

  void testNestedConditions() {
    bool condition1 = true;
    bool condition2 = false;

    // Nested if with different branches
    if (condition1) {
      if (condition2) {
        print('nested1');
      }
    } else {
      if (condition2) {
        print('nested2');
      }
    }
  }

  void testComplexStatements() {
    bool condition = true;
    final list = <int>[1, 2, 3];

    // If-else with different complex statements
    if (condition) {
      list.add(5);
      list.removeAt(0);
    } else {
      list.add(10);
      list.removeAt(1);
    }
  }
}
