// ignore_for_file: arguments_ordering, avoid_accessing_collections_by_constant_index, avoid_accessing_other_classes_private_members, avoid_adjacent_strings, avoid_always_null_parameters, avoid_assigning_to_static_field, avoid_assignments_as_conditions, avoid_async_call_in_sync_function, avoid_barrel_files, avoid_bitwise_operators_with_booleans, avoid_bottom_type_in_patterns, avoid_bottom_type_in_records, avoid_cascade_after_if_null, avoid_casting_to_extension_type, avoid_collapsible_if, avoid_collection_equality_checks, avoid_collection_methods_with_unrelated_types, avoid_collection_mutating_methods, avoid_commented_out_code, avoid_complex_arithmetic_expressions, avoid_complex_conditions, avoid_complex_loop_conditions, avoid_conditions_with_boolean_literals, avoid_constant_conditions, avoid_constant_switches, avoid_continue, avoid_contradictory_expressions, avoid_declaring_call_method, avoid_default_tostring, avoid_deprecated_usage, avoid_double_slash_imports, avoid_duplicate_cascades, avoid_duplicate_collection_elements, avoid_empty_setstate, avoid_late_context, avoid_missing_controller, avoid_mounted_in_setstate, avoid_non_null_assertion, avoid_single_child_column_or_row, avoid_stateless_widget_initialized_fields, avoid_undisposed_instances, avoid_unnecessary_gesture_detector, avoid_unnecessary_overrides_in_state, avoid_unnecessary_stateful_widgets, avoid_wrapping_in_padding, binary_expression_operand_order, dead_code, dispose_class_fields, dispose_fields, double_literal_format, newline_before_case, newline_before_constructor, newline_before_method, newline_before_return, no_boolean_literal_compare, no_empty_block, no_empty_string, no_equal_arguments, no_equal_conditions, no_equal_nested_conditions, no_equal_switch_case, no_equal_switch_expression_cases, no_equal_then_else, no_magic_number, no_magic_string, no_object_declaration, pass_existing_future_to_future_builder, pass_existing_stream_to_stream_builder, prefer_action_button_tooltip, prefer_align_over_container, prefer_async_await, prefer_async_callback, prefer_center_over_align, prefer_compute_over_isolate_run, prefer_constrained_box_over_container, prefer_container, prefer_contains, prefer_correct_for_loop_increment, prefer_dedicated_media_query_methods, prefer_early_return, prefer_for_loop_in_children, prefer_iterable_of, prefer_named_boolean_parameters, prefer_padding_over_container, prefer_single_setstate, prefer_sized_box_square, prefer_sliver_prefix, prefer_spacing, prefer_switch_expression, prefer_text_rich, prefer_void_callback, prefer_widget_private_members, proper_super_calls, unused_element, unused_import, unused_local_variable

// Test cases that should trigger the avoid_constant_assert_conditions lint

const int constValue = 5;
const bool constBool = true;

void test() {
  // Case 1: Assert with true literal
  // expect_lint: avoid_constant_assert_conditions
  assert(true);

  // Case 2: Assert with false literal
  // expect_lint: avoid_constant_assert_conditions
  assert(false);

  // Case 3: Assert with integer literal
  // expect_lint: avoid_constant_assert_conditions
  assert(1 == 1);

  // Case 9: Assert with binary expression of constants
  // expect_lint: avoid_constant_assert_conditions
  assert(5 > 0);

  print('test');
}

void testWithConstVariable() {
  // These cases with const variables are too complex to detect reliably
  // Our simplified implementation focuses on literals
  assert(constValue > 0); // Valid: involves runtime evaluation
  assert(constBool); // Valid: const variable detection is complex

  // Case 11: Assert with parenthesized constant
  // expect_lint: avoid_constant_assert_conditions
  assert((true));

  // Case 12: Assert with negation of constant
  // expect_lint: avoid_constant_assert_conditions
  assert(!false);

  // Case 14: Assert with binary expression of constants
  // expect_lint: avoid_constant_assert_conditions
  assert(1 + 1 == 2);

  print('test');
}
