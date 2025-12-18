// ignore_for_file: arguments_ordering, avoid_accessing_collections_by_constant_index, avoid_accessing_other_classes_private_members, avoid_adjacent_strings, avoid_always_null_parameters, avoid_assigning_to_static_field, avoid_assignments_as_conditions, avoid_async_call_in_sync_function, avoid_barrel_files, avoid_bitwise_operators_with_booleans, avoid_bottom_type_in_patterns, avoid_bottom_type_in_records, avoid_cascade_after_if_null, avoid_casting_to_extension_type, avoid_collapsible_if, avoid_collection_equality_checks, avoid_collection_methods_with_unrelated_types, avoid_collection_mutating_methods, avoid_commented_out_code, avoid_complex_arithmetic_expressions, avoid_complex_conditions, avoid_complex_loop_conditions, avoid_conditions_with_boolean_literals, avoid_constant_assert_conditions, avoid_constant_conditions, avoid_constant_switches, avoid_continue, avoid_contradictory_expressions, avoid_declaring_call_method, avoid_default_tostring, avoid_deprecated_usage, avoid_double_slash_imports, avoid_duplicate_cascades, avoid_duplicate_collection_elements, avoid_empty_setstate, avoid_late_context, avoid_missing_controller, avoid_mounted_in_setstate, avoid_non_null_assertion, avoid_single_child_column_or_row, avoid_stateless_widget_initialized_fields, avoid_undisposed_instances, avoid_unnecessary_gesture_detector, avoid_unnecessary_overrides_in_state, avoid_unnecessary_stateful_widgets, avoid_wrapping_in_padding, binary_expression_operand_order, dead_code, dispose_class_fields, dispose_fields, double_literal_format, newline_before_case, newline_before_constructor, newline_before_method, newline_before_return, no_boolean_literal_compare, no_empty_block, no_empty_string, no_equal_arguments, no_equal_nested_conditions, no_equal_switch_case, no_equal_switch_expression_cases, no_equal_then_else, no_magic_number, no_magic_string, no_object_declaration, pass_existing_future_to_future_builder, pass_existing_stream_to_stream_builder, prefer_action_button_tooltip, prefer_align_over_container, prefer_async_callback, prefer_center_over_align, prefer_compute_over_isolate_run, prefer_constrained_box_over_container, prefer_container, prefer_dedicated_media_query_methods, prefer_for_loop_in_children, prefer_padding_over_container, prefer_single_setstate, prefer_sized_box_square, prefer_sliver_prefix, prefer_spacing, prefer_text_rich, prefer_void_callback, prefer_widget_private_members, proper_super_calls, unused_element, unused_import, unused_local_variable

void allUniqueConditions() {
  final value = 1;

  if (value == 1) {
    print('first');
  } else if (value == 2) {
    print('second');
  } else if (value == 3) {
    print('third');
  }
}

void differentComplexConditions() {
  final x = 10;
  final y = 20;

  if (x > 5 && y < 30) {
    print('first');
  } else if (x > 5 && y < 25) {
    print('different');
  } else if (x < 5 && y < 30) {
    print('also different');
  }
}

void simpleIfWithoutElse() {
  final value = 1;

  if (value == 1) {
    print('only one condition');
  }
}

void ifElseWithoutElseIf() {
  final value = 1;

  if (value == 1) {
    print('if branch');
  } else {
    print('else branch');
  }
}

void differentNullChecks() {
  String? text;

  print('is null');
}

void differentMethodCalls() {
  final list = [1, 2, 3];

  if (list.isEmpty) {
    print('empty');
  } else if (list.length > 5) {
    print('large');
  } else if (list.length < 2) {
    print('small');
  }
}

void differentComparisons() {
  final age = 25;

  if (age < 18) {
    print('minor');
  } else if (age >= 18 && age < 65) {
    print('adult');
  } else if (age >= 65) {
    print('senior');
  }
}

void differentEquality() {
  final name = 'test';

  if (name == 'Alice') {
    print('Alice');
  } else if (name == 'Bob') {
    print('Bob');
  } else if (name == 'Charlie') {
    print('Charlie');
  }
}

void nestedIfStatements() {
  final x = 5;
  final y = 10;

  if (x == 5) {
    if (y == 10) {
      print('nested');
    }
  } else if (x == 6) {
    print('different outer');
  }
}

void differentLogicalOperators() {
  final value = 10;

  if (value == 1 || value == 2) {
    print('one or two');
  } else if (value == 1 && value == 2) {
    print('different operator');
  } else if (value == 3 || value == 4) {
    print('three or four');
  }
}
