// ignore_for_file: arguments_ordering, avoid_accessing_collections_by_constant_index, avoid_accessing_other_classes_private_members, avoid_adjacent_strings, avoid_always_null_parameters, avoid_assigning_to_static_field, avoid_assignments_as_conditions, avoid_async_call_in_sync_function, avoid_barrel_files, avoid_bitwise_operators_with_booleans, avoid_bottom_type_in_patterns, avoid_bottom_type_in_records, avoid_cascade_after_if_null, avoid_casting_to_extension_type, avoid_collapsible_if, avoid_collection_equality_checks, avoid_collection_methods_with_unrelated_types, avoid_collection_mutating_methods, avoid_commented_out_code, avoid_complex_arithmetic_expressions, avoid_complex_conditions, avoid_complex_loop_conditions, avoid_conditions_with_boolean_literals, avoid_constant_assert_conditions, avoid_constant_conditions, avoid_constant_switches, avoid_continue, avoid_contradictory_expressions, avoid_declaring_call_method, avoid_default_tostring, avoid_deprecated_usage, avoid_double_slash_imports, avoid_duplicate_cascades, avoid_duplicate_collection_elements, avoid_empty_setstate, avoid_late_context, avoid_missing_controller, avoid_mounted_in_setstate, avoid_single_child_column_or_row, avoid_stateless_widget_initialized_fields, avoid_undisposed_instances, avoid_unnecessary_gesture_detector, avoid_unnecessary_overrides_in_state, avoid_unnecessary_stateful_widgets, avoid_wrapping_in_padding, binary_expression_operand_order, dead_code, dispose_class_fields, dispose_fields, double_literal_format, newline_before_case, newline_before_constructor, newline_before_method, newline_before_return, no_boolean_literal_compare, no_empty_block, no_empty_string, no_equal_arguments, no_equal_conditions, no_equal_nested_conditions, no_equal_switch_case, no_equal_switch_expression_cases, no_equal_then_else, no_magic_number, no_magic_string, no_object_declaration, pass_existing_future_to_future_builder, pass_existing_stream_to_stream_builder, prefer_action_button_tooltip, prefer_align_over_container, prefer_async_callback, prefer_center_over_align, prefer_compute_over_isolate_run, prefer_constrained_box_over_container, prefer_container, prefer_dedicated_media_query_methods, prefer_for_loop_in_children, prefer_padding_over_container, prefer_single_setstate, prefer_sized_box_square, prefer_sliver_prefix, prefer_spacing, prefer_text_rich, prefer_void_callback, prefer_widget_private_members, proper_super_calls, unused_element, unused_import, unused_local_variable

class Test {
  String? field;
  Test? object;
  int? number;

  void method() {
    // Basic non-null assertion on property access
    // expect_lint: avoid_non_null_assertion
    field!.contains('other');

    // Chained non-null assertions
    // expect_lint: avoid_non_null_assertion
    object!.field!.contains('other');

    // Non-null assertion on method invocation
    // expect_lint: avoid_non_null_assertion
    object!.method();

    // Non-null assertion on property
    // expect_lint: avoid_non_null_assertion
    final value = field!;

    // Non-null assertion in expression
    // expect_lint: avoid_non_null_assertion
    final length = field!.length;

    // Non-null assertion with arithmetic
    // expect_lint: avoid_non_null_assertion
    final result = number! + 5;

    // Non-null assertion in condition
    // expect_lint: avoid_non_null_assertion
    if (field!.isEmpty) {
      print('empty');
    }

    // Non-null assertion in list
    final list = <String?>[null, 'hello'];
    // expect_lint: avoid_non_null_assertion
    final item = list[0]!;

    // Multiple assertions in one line
    // expect_lint: avoid_non_null_assertion
    final nested = object!.object!.field;
  }

  String? getValue() => null;

  void testMethodCall() {
    // Non-null assertion on method return
    // expect_lint: avoid_non_null_assertion
    getValue()!.contains('test');
  }
}

// Non-null assertion on function parameter
void processString(String? input) {
  // expect_lint: avoid_non_null_assertion
  print(input!.toUpperCase());
}

// Non-null assertion in field initializer
class MyClass {
  String? nullable;

  // expect_lint: avoid_non_null_assertion
  late String value = nullable!;
}

// Map index operations with non-null assertion
void mapOperations() {
  final map = <String, String>{'a': 'alpha', 'b': 'beta'};

  // expect_lint: avoid_non_null_assertion
  final value1 = map['a']!;

  // expect_lint: avoid_non_null_assertion
  final value2 = map['b']!.toUpperCase();

  // Nested maps
  final nestedMap = <String, Map<String, String>>{
    'outer': {'inner': 'value'}
  };

  // expect_lint: avoid_non_null_assertion
  final innerValue = nestedMap['outer']!['inner']!;
}
