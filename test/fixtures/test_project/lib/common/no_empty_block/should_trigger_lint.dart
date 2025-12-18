// ignore_for_file: arguments_ordering, avoid_accessing_collections_by_constant_index, avoid_accessing_other_classes_private_members, avoid_adjacent_strings, avoid_always_null_parameters, avoid_assigning_to_static_field, avoid_assignments_as_conditions, avoid_async_call_in_sync_function, avoid_barrel_files, avoid_bitwise_operators_with_booleans, avoid_bottom_type_in_patterns, avoid_bottom_type_in_records, avoid_cascade_after_if_null, avoid_casting_to_extension_type, avoid_collapsible_if, avoid_collection_equality_checks, avoid_collection_methods_with_unrelated_types, avoid_collection_mutating_methods, avoid_commented_out_code, avoid_complex_arithmetic_expressions, avoid_complex_conditions, avoid_complex_loop_conditions, avoid_conditions_with_boolean_literals, avoid_constant_assert_conditions, avoid_constant_conditions, avoid_constant_switches, avoid_continue, avoid_contradictory_expressions, avoid_declaring_call_method, avoid_default_tostring, avoid_deprecated_usage, avoid_double_slash_imports, avoid_duplicate_cascades, avoid_duplicate_collection_elements, avoid_empty_setstate, avoid_late_context, avoid_missing_controller, avoid_mounted_in_setstate, avoid_non_null_assertion, avoid_single_child_column_or_row, avoid_stateless_widget_initialized_fields, avoid_undisposed_instances, avoid_unnecessary_gesture_detector, avoid_unnecessary_overrides_in_state, avoid_unnecessary_stateful_widgets, avoid_wrapping_in_padding, binary_expression_operand_order, dead_code, dispose_class_fields, dispose_fields, double_literal_format, newline_before_case, newline_before_constructor, newline_before_method, newline_before_return, no_boolean_literal_compare, no_empty_string, no_equal_arguments, no_equal_conditions, no_equal_nested_conditions, no_equal_switch_case, no_equal_switch_expression_cases, no_equal_then_else, no_magic_number, no_magic_string, no_object_declaration, pass_existing_future_to_future_builder, pass_existing_stream_to_stream_builder, prefer_action_button_tooltip, prefer_align_over_container, prefer_async_callback, prefer_center_over_align, prefer_compute_over_isolate_run, prefer_constrained_box_over_container, prefer_container, prefer_dedicated_media_query_methods, prefer_for_loop_in_children, prefer_padding_over_container, prefer_single_setstate, prefer_sized_box_square, prefer_sliver_prefix, prefer_spacing, prefer_text_rich, prefer_void_callback, prefer_widget_private_members, proper_super_calls, unused_element, unused_import, unused_local_variable

class Test {
  // Empty method
  // expect_lint: no_empty_block
  void emptyMethod() {}

  // Empty if block
  void testIf(bool condition) {
    // expect_lint: no_empty_block
    if (condition) {}
  }

  // Empty else block
  void testElse(bool condition) {
    if (condition) {
      print('true');
      // expect_lint: no_empty_block
    } else {}
  }

  // Empty for loop
  void testForLoop() {
    // expect_lint: no_empty_block
    for (var i = 0; i < 10; i++) {}
  }

  // Empty while loop
  void testWhile(bool condition) {
    // expect_lint: no_empty_block
    while (condition) {}
  }

  // Empty do-while loop
  void testDoWhile(bool condition) {
    // expect_lint: no_empty_block
    do {} while (condition);
  }

  // Empty forEach
  void testForEach() {
    // expect_lint: no_empty_block
    [1, 2, 3, 4].forEach((val) {});
  }

  // Empty switch case
  void testSwitch(int value) {
    switch (value) {
      case 1:
        // expect_lint: no_empty_block
        {}
        break;

      case 2:
        print('two');
        break;
    }
  }

  // Empty try block
  void testTry() {
    // expect_lint: no_empty_block
    try {} catch (e) {
      print(e);
    }
  }

  // Empty finally block
  void testFinally() {
    try {
      print('try');
      // expect_lint: no_empty_block
    } finally {}
  }

  // Nested empty blocks
  void testNested(bool condition) {
    if (condition) {
      // expect_lint: no_empty_block
      if (condition) {}
    }
  }

  // Empty constructor
  // expect_lint: no_empty_block
  Test() {}

  // Empty named constructor
  // expect_lint: no_empty_block
  Test.named() {}

  // Empty getter with block
  // expect_lint: no_empty_block
  int get value {} // ignore: body_might_complete_normally

  // Empty setter
  // expect_lint: no_empty_block
  set value(int v) {}
}

// Empty top-level function
// expect_lint: no_empty_block
void emptyFunction() {}

// Empty class with empty constructor
class EmptyClass {
  // expect_lint: no_empty_block
  EmptyClass() {}
}

// Empty static method
class StaticTest {
  // expect_lint: no_empty_block
  static void emptyStatic() {}
}

// Empty async function
// expect_lint: no_empty_block
Future<void> emptyAsync() async {}

// Empty callback
void callbackTest() {
  void Function() callback;
  // expect_lint: no_empty_block
  callback = () {};
}

// Empty map function
void mapTest() {
  // expect_lint: no_empty_block
  [1, 2, 3].map((e) {});
}

// Empty then callback
void futureTest() {
  // expect_lint: no_empty_block
  Future.value(1).then((value) {});
}
