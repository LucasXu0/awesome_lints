// ignore_for_file: arguments_ordering, avoid_accessing_collections_by_constant_index, avoid_accessing_other_classes_private_members, avoid_adjacent_strings, avoid_always_null_parameters, avoid_assigning_to_static_field, avoid_assignments_as_conditions, avoid_async_call_in_sync_function, avoid_barrel_files, avoid_bitwise_operators_with_booleans, avoid_bottom_type_in_patterns, avoid_bottom_type_in_records, avoid_cascade_after_if_null, avoid_casting_to_extension_type, avoid_collapsible_if, avoid_collection_equality_checks, avoid_collection_mutating_methods, avoid_commented_out_code, avoid_complex_arithmetic_expressions, avoid_complex_conditions, avoid_complex_loop_conditions, avoid_conditions_with_boolean_literals, avoid_constant_assert_conditions, avoid_constant_conditions, avoid_constant_switches, avoid_continue, avoid_contradictory_expressions, avoid_declaring_call_method, avoid_default_tostring, avoid_deprecated_usage, avoid_double_slash_imports, avoid_duplicate_cascades, avoid_duplicate_collection_elements, avoid_empty_setstate, avoid_late_context, avoid_missing_controller, avoid_mounted_in_setstate, avoid_non_null_assertion, avoid_single_child_column_or_row, avoid_stateless_widget_initialized_fields, avoid_undisposed_instances, avoid_unnecessary_gesture_detector, avoid_unnecessary_overrides_in_state, avoid_unnecessary_stateful_widgets, avoid_wrapping_in_padding, binary_expression_operand_order, dead_code, dispose_class_fields, dispose_fields, double_literal_format, newline_before_case, newline_before_constructor, newline_before_method, newline_before_return, no_boolean_literal_compare, no_empty_block, no_empty_string, no_equal_arguments, no_equal_conditions, no_equal_nested_conditions, no_equal_switch_case, no_equal_switch_expression_cases, no_equal_then_else, no_magic_number, no_magic_string, no_object_declaration, pass_existing_future_to_future_builder, pass_existing_stream_to_stream_builder, prefer_action_button_tooltip, prefer_align_over_container, prefer_async_callback, prefer_center_over_align, prefer_compute_over_isolate_run, prefer_constrained_box_over_container, prefer_container, prefer_dedicated_media_query_methods, prefer_for_loop_in_children, prefer_padding_over_container, prefer_single_setstate, prefer_sized_box_square, prefer_sliver_prefix, prefer_spacing, prefer_text_rich, prefer_void_callback, prefer_widget_private_members, proper_super_calls, unused_element, unused_import, unused_local_variable

// Test cases that should NOT trigger the prefer_iterable_of lint

void test() {
  final List<num> numList = [1, 2.5, 3];
  final List<int> intList = [1, 2, 3];
  final Set<String> stringSet = {'a', 'b', 'c'};
  final List<String> stringList = ['x', 'y', 'z'];

  // Valid: Using .of() instead of .from()
  final list1 = List<int>.of(intList);
  final set1 = Set<String>.of(stringSet);

  // Valid: Type conversion - List<int>.from(List<num>)
  // int is not directly assignable from num, requires conversion
  final list2 = List<int>.from(numList);

  // Valid: Type conversion - List<num>.from(List<int>)
  // Converting to a different type (widening is OK with .from)
  final list3 = List<num>.from(intList);

  // Valid: Dynamic source
  final dynamicList = <dynamic>[1, 'two', true];
  final list4 = List<int>.from(dynamicList);

  // Valid: Using other constructors
  final list5 = List<int>.empty();
  final list6 = List<int>.filled(5, 0);
  final list7 = List<int>.generate(5, (i) => i);
  final set2 = Set<String>.identity();

  // Valid: Map (not List or Set)
  final map1 = Map<int, String>.from({1: 'one', 2: 'two'});

  // Valid: Using .toList() or .toSet()
  final list8 = stringSet.toList();
  final set3 = stringList.toSet();

  // Valid: Spread operator
  final list9 = <int>[...intList];
  final set4 = <String>{...stringSet};

  // Valid: Other methods
  final list10 = List.unmodifiable(intList);

  print(
    '$list1 $list2 $list3 $list4 $list5 $list6 $list7 $list8 $list9 $list10 $set1 $set2 $set3 $set4 $map1',
  );
}
