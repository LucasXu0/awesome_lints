// ignore_for_file: arguments_ordering, avoid_accessing_collections_by_constant_index, avoid_accessing_other_classes_private_members, avoid_adjacent_strings, avoid_always_null_parameters, avoid_assigning_to_static_field, avoid_assignments_as_conditions, avoid_async_call_in_sync_function, avoid_barrel_files, avoid_bitwise_operators_with_booleans, avoid_bottom_type_in_patterns, avoid_bottom_type_in_records, avoid_cascade_after_if_null, avoid_casting_to_extension_type, avoid_collapsible_if, avoid_collection_equality_checks, avoid_collection_methods_with_unrelated_types, avoid_collection_mutating_methods, avoid_commented_out_code, avoid_complex_arithmetic_expressions, avoid_complex_conditions, avoid_complex_loop_conditions, avoid_conditions_with_boolean_literals, avoid_constant_assert_conditions, avoid_constant_conditions, avoid_constant_switches, avoid_continue, avoid_contradictory_expressions, avoid_declaring_call_method, avoid_default_tostring, avoid_deprecated_usage, avoid_double_slash_imports, avoid_duplicate_cascades, avoid_duplicate_collection_elements, avoid_empty_setstate, avoid_late_context, avoid_missing_controller, avoid_mounted_in_setstate, avoid_non_null_assertion, avoid_single_child_column_or_row, avoid_stateless_widget_initialized_fields, avoid_undisposed_instances, avoid_unnecessary_gesture_detector, avoid_unnecessary_overrides_in_state, avoid_unnecessary_stateful_widgets, avoid_wrapping_in_padding, binary_expression_operand_order, dead_code, dispose_class_fields, dispose_fields, double_literal_format, newline_before_constructor, newline_before_method, newline_before_return, no_boolean_literal_compare, no_empty_block, no_empty_string, no_equal_arguments, no_equal_conditions, no_equal_nested_conditions, no_equal_switch_case, no_equal_switch_expression_cases, no_equal_then_else, no_magic_number, no_magic_string, no_object_declaration, pass_existing_future_to_future_builder, pass_existing_stream_to_stream_builder, prefer_action_button_tooltip, prefer_align_over_container, prefer_async_await, prefer_async_callback, prefer_center_over_align, prefer_compute_over_isolate_run, prefer_constrained_box_over_container, prefer_container, prefer_contains, prefer_correct_for_loop_increment, prefer_dedicated_media_query_methods, prefer_early_return, prefer_for_loop_in_children, prefer_iterable_of, prefer_named_boolean_parameters, prefer_padding_over_container, prefer_single_setstate, prefer_sized_box_square, prefer_sliver_prefix, prefer_spacing, prefer_switch_expression, prefer_text_rich, prefer_void_callback, prefer_widget_private_members, proper_super_calls, unused_element, unused_import, unused_local_variable

// First case doesn't need spacing
void firstCaseNoLint() {
  final value = 1;
  switch (value) {
    case 1:
      print('one');
      break;
  }
}

// Proper spacing between cases
void properSpacing() {
  final value = 1;
  switch (value) {
    case 1:
      print('one');
      break;

    case 2:
      print('two');
      break;

    case 3:
      print('three');
      break;
  }
}

// Fallthrough cases (no statements) don't need spacing
void fallthroughCases() {
  final value = 1;
  switch (value) {
    case 1:
    case 2:
    case 3:
      print('one, two, or three');
      break;

    case 4:
    case 5:
      print('four or five');
      break;
  }
}

// Mixed fallthrough and regular cases
void mixedCases() {
  final value = 1;
  switch (value) {
    case 1:
    case 2:
      print('one or two');
      break;

    case 3:
      print('three');
      break;

    case 4:
    case 5:
    case 6:
      print('four, five, or six');
      break;
  }
}

// Single case switch
void singleCase() {
  final value = 1;
  switch (value) {
    case 1:
      print('only one');
      break;
  }
}

// Proper spacing with blocks
void blocksWithSpacing() {
  final value = 1;
  switch (value) {
    case 1:
      {
        print('block one');
      }

    case 2:
      {
        print('block two');
      }
  }
}

// Proper spacing with default
void withDefaultProperSpacing() {
  final value = 1;
  switch (value) {
    case 1:
      print('one');
      break;

    case 2:
      print('two');
      break;

    default:
      print('default');
  }
}

// Return statements with proper spacing
String switchWithReturns(int value) {
  switch (value) {
    case 1:
      return 'one';

    case 2:
      return 'two';

    default:
      return 'other';
  }
}

// Nested switch with proper spacing
void nestedSwitchProper() {
  final outer = 1;
  switch (outer) {
    case 1:
      final inner = 2;
      switch (inner) {
        case 1:
          print('inner 1');
          break;

        case 2:
          print('inner 2');
          break;
      }
      break;

    case 2:
      print('outer 2');
      break;
  }
}

// Multiple statements per case with proper spacing
void multipleStatementsProper() {
  final value = 1;
  switch (value) {
    case 1:
      print('first');
      print('statement');
      break;

    case 2:
      print('second');
      print('case');
      break;
  }
}

// Complex control flow with proper spacing
void complexControlFlow() {
  final value = 1;
  switch (value) {
    case 1:
      for (var i = 0; i < 10; i++) {
        print(i);
      }
      break;

    case 2:
      if (value == 2) {
        print('two');
      }
      break;

    case 3:
      while (value < 10) {
        print(value);
        break;
      }
      break;
  }
}

// Empty switch (no cases)
void emptySwitch() {
  final value = 1;
  switch (value) {}
}

// Fallthrough to case with statements
void fallthroughToStatements() {
  final value = 1;
  switch (value) {
    case 1:
    case 2:
      print('one or two');
      break;

    case 3:
      print('three');
      break;
  }
}
