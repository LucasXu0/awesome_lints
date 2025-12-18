// ignore_for_file: arguments_ordering, avoid_accessing_collections_by_constant_index, avoid_accessing_other_classes_private_members, avoid_adjacent_strings, avoid_always_null_parameters, avoid_assigning_to_static_field, avoid_assignments_as_conditions, avoid_async_call_in_sync_function, avoid_barrel_files, avoid_bitwise_operators_with_booleans, avoid_bottom_type_in_patterns, avoid_bottom_type_in_records, avoid_cascade_after_if_null, avoid_casting_to_extension_type, avoid_collapsible_if, avoid_collection_equality_checks, avoid_collection_methods_with_unrelated_types, avoid_collection_mutating_methods, avoid_commented_out_code, avoid_complex_arithmetic_expressions, avoid_complex_conditions, avoid_complex_loop_conditions, avoid_conditions_with_boolean_literals, avoid_constant_assert_conditions, avoid_constant_conditions, avoid_constant_switches, avoid_continue, avoid_contradictory_expressions, avoid_declaring_call_method, avoid_default_tostring, avoid_deprecated_usage, avoid_double_slash_imports, avoid_duplicate_cascades, avoid_duplicate_collection_elements, avoid_empty_setstate, avoid_late_context, avoid_missing_controller, avoid_mounted_in_setstate, avoid_non_null_assertion, avoid_single_child_column_or_row, avoid_stateless_widget_initialized_fields, avoid_undisposed_instances, avoid_unnecessary_gesture_detector, avoid_unnecessary_overrides_in_state, avoid_unnecessary_stateful_widgets, avoid_wrapping_in_padding, binary_expression_operand_order, constant_pattern_never_matches_value_type, dead_code, dispose_class_fields, dispose_fields, double_literal_format, newline_before_case, newline_before_constructor, newline_before_method, newline_before_return, no_boolean_literal_compare, no_empty_block, no_empty_string, no_equal_arguments, no_equal_conditions, no_equal_nested_conditions, no_equal_switch_case, no_equal_then_else, no_magic_number, no_magic_string, no_object_declaration, non_exhaustive_switch_expression, pass_existing_future_to_future_builder, pass_existing_stream_to_stream_builder, prefer_action_button_tooltip, prefer_align_over_container, prefer_async_callback, prefer_center_over_align, prefer_compute_over_isolate_run, prefer_constrained_box_over_container, prefer_container, prefer_dedicated_media_query_methods, prefer_for_loop_in_children, prefer_padding_over_container, prefer_single_setstate, prefer_sized_box_square, prefer_sliver_prefix, prefer_spacing, prefer_text_rich, prefer_void_callback, prefer_widget_private_members, proper_super_calls, unused_element, unused_import, unused_local_variable

void basicDuplicateExpression() {
  final value = 1;

  final result = switch (value) {
    1 => 'one',
    2 => 'duplicate',
    // expect_lint: no_equal_switch_expression_cases
    3 => 'duplicate',
  };
}

void multipleDuplicates() {
  final value = 5;

  final result = switch (value) {
    1 => 'first',
    2 => 'same',
    // expect_lint: no_equal_switch_expression_cases
    3 => 'same',
    // expect_lint: no_equal_switch_expression_cases
    4 => 'same',
  };
}

void duplicateComplexExpression() {
  final value = 10;

  final result = switch (value) {
    1 => value * 2 + 5,
    2 => value - 3,
    // expect_lint: no_equal_switch_expression_cases
    3 => value * 2 + 5,
  };
}

void duplicateStringLiteral() {
  final str = 'test';

  final result = switch (str) {
    'a' => 'alpha',
    'b' => 'beta',
    // expect_lint: no_equal_switch_expression_cases
    'c' => 'alpha',
  };
}

void duplicateMethodCall() {
  final str = 'test';

  final result = switch (str) {
    'a' => str.toUpperCase(),
    'b' => str.toLowerCase(),
    // expect_lint: no_equal_switch_expression_cases
    'c' => str.toUpperCase(),
  };
}

void duplicateNumberLiteral() {
  final value = 5;

  final result = switch (value) {
    1 => 100,
    2 => 200,
    // expect_lint: no_equal_switch_expression_cases
    3 => 100,
  };
}

void duplicateBooleanExpression() {
  final value = true;

  final result = switch (value) {
    true => 1,
    false => 2,
  };
}

void duplicateWithWildcard() {
  final value = 10;

  final result = switch (value) {
    1 => 'one',
    2 => 'two',
    // expect_lint: no_equal_switch_expression_cases
    _ => 'one',
  };
}

sealed class Shape {}

class Circle extends Shape {}

class Square extends Shape {}

class Triangle extends Shape {}

void duplicatePatternMatching() {
  final shape = Circle();

  final result = switch (shape) {
    Circle() => 'round',
    Square() => 'angular',
    // expect_lint: no_equal_switch_expression_cases
    Triangle() => 'round',
  };
}

void duplicateWithVariable() {
  final value = 5;

  final result = switch (value) {
    1 => value + 10,
    2 => value * 2,
    // expect_lint: no_equal_switch_expression_cases
    3 => value + 10,
  };
}

void duplicateNullCheck() {
  int? value = 5;

  final result = switch (value) {
    null => 0,
    1 => 100,
    // expect_lint: no_equal_switch_expression_cases
    _ => 0,
  };
}

void duplicateListLiteral() {
  final value = 1;

  final result = switch (value) {
    1 => [1, 2, 3],
    2 => [4, 5, 6],
    // expect_lint: no_equal_switch_expression_cases
    3 => [1, 2, 3],
  };
}

void duplicateMapLiteral() {
  final value = 1;

  final result = switch (value) {
    1 => {'key': 'value'},
    2 => {'other': 'data'},
    // expect_lint: no_equal_switch_expression_cases
    3 => {'key': 'value'},
  };
}

void duplicateTernary() {
  final value = 5;

  final result = switch (value) {
    1 => value > 0 ? 'positive' : 'negative',
    2 => value == 0 ? 'zero' : 'nonzero',
    // expect_lint: no_equal_switch_expression_cases
    3 => value > 0 ? 'positive' : 'negative',
  };
}
