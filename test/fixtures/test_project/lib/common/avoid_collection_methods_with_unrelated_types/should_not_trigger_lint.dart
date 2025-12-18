// ignore_for_file: arguments_ordering, avoid_accessing_collections_by_constant_index, avoid_accessing_other_classes_private_members, avoid_adjacent_strings, avoid_always_null_parameters, avoid_assigning_to_static_field, avoid_assignments_as_conditions, avoid_async_call_in_sync_function, avoid_barrel_files, avoid_bitwise_operators_with_booleans, avoid_bottom_type_in_patterns, avoid_bottom_type_in_records, avoid_cascade_after_if_null, avoid_casting_to_extension_type, avoid_collapsible_if, avoid_collection_equality_checks, avoid_collection_mutating_methods, avoid_commented_out_code, avoid_complex_arithmetic_expressions, avoid_complex_conditions, avoid_complex_loop_conditions, avoid_conditions_with_boolean_literals, avoid_constant_assert_conditions, avoid_constant_conditions, avoid_constant_switches, avoid_continue, avoid_contradictory_expressions, avoid_declaring_call_method, avoid_default_tostring, avoid_deprecated_usage, avoid_double_slash_imports, avoid_duplicate_cascades, avoid_duplicate_collection_elements, avoid_empty_setstate, avoid_late_context, avoid_missing_controller, avoid_mounted_in_setstate, avoid_non_null_assertion, avoid_single_child_column_or_row, avoid_stateless_widget_initialized_fields, avoid_undisposed_instances, avoid_unnecessary_gesture_detector, avoid_unnecessary_overrides_in_state, avoid_unnecessary_stateful_widgets, avoid_wrapping_in_padding, binary_expression_operand_order, dead_code, dispose_class_fields, dispose_fields, double_literal_format, newline_before_case, newline_before_constructor, newline_before_method, newline_before_return, no_boolean_literal_compare, no_empty_block, no_empty_string, no_equal_arguments, no_equal_conditions, no_equal_nested_conditions, no_equal_switch_case, no_equal_switch_expression_cases, no_equal_then_else, no_magic_number, no_magic_string, no_object_declaration, pass_existing_future_to_future_builder, pass_existing_stream_to_stream_builder, prefer_action_button_tooltip, prefer_align_over_container, prefer_async_callback, prefer_center_over_align, prefer_compute_over_isolate_run, prefer_constrained_box_over_container, prefer_container, prefer_dedicated_media_query_methods, prefer_for_loop_in_children, prefer_padding_over_container, prefer_single_setstate, prefer_sized_box_square, prefer_sliver_prefix, prefer_spacing, prefer_text_rich, prefer_void_callback, prefer_widget_private_members, proper_super_calls, unused_element, unused_import, unused_local_variable

// Test cases that should NOT trigger the avoid_collection_methods_with_unrelated_types lint

void test() {
  final List<int> intList = [1, 2, 3];
  final Set<String> stringSet = {'a', 'b', 'c'};
  final Map<int, String> intStringMap = {1: 'one', 2: 'two'};
  final List<String> stringList = ['a', 'b', 'c'];
  final List<num> numList = [1, 2.5, 3];

  // Valid: List<int>.contains with int argument
  final contains1 = intList.contains(1);

  // Valid: List<int>.indexOf with int argument
  final index2 = intList.indexOf(2);

  // Valid: List<int>.indexOf with int argument
  final index1 = intList.indexOf(3);

  // Valid: Set<String>.contains with String argument
  final contains2 = stringSet.contains('a');

  // Valid: Set<String>.lookup with String argument
  final lookup1 = stringSet.lookup('b');

  // Valid: Map<int, String>.containsKey with int argument
  final hasKey = intStringMap.containsKey(1);

  // Valid: Map<int, String>.containsValue with String argument
  final hasValue = intStringMap.containsValue('one');

  // Valid: Map<int, String>.containsKey with int key
  final hasKey2 = intStringMap.containsKey(2);

  // Valid: Map index access with correct key type
  final value = intStringMap[1];

  // Valid: List index access with int
  final item = stringList[0];

  // Valid: List<String>.lastIndexOf with String argument
  final lastIndex = stringList.lastIndexOf('c');

  // Valid: Subtype compatibility - int is subtype of num
  final numContains = numList.contains(1);
  final numIndex = numList.indexOf(2.5);

  // Valid: Dynamic collections (no type checking)
  final dynamicList = <dynamic>[1, 'two', true];
  dynamicList.contains('anything');
  final dynIndex = dynamicList.indexOf(123);

  // Valid: Object type (accepts anything)
  final objectList = <Object>[1, 'two', true];
  objectList.contains('test');

  // Valid: Nullable types
  final nullableIntList = <int?>[1, 2, null];
  nullableIntList.contains(null);

  // Valid: Methods that don't check element type
  final length = intList.length;
  final isEmpty = stringSet.isEmpty;
  final keys = intStringMap.keys;

  print(
      '$contains1 $contains2 $index1 $index2 $hasKey $hasValue $hasKey2 $value $item $lastIndex $numContains $numIndex $lookup1 $dynIndex $length $isEmpty $keys');
}
