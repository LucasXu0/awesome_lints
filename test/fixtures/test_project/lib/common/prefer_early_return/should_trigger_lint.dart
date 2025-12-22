// ignore_for_file: arguments_ordering,avoid_accessing_collections_by_constant_index,avoid_accessing_other_classes_private_members,avoid_adjacent_strings,avoid_always_null_parameters,avoid_assigning_to_static_field,avoid_assignments_as_conditions,avoid_async_call_in_sync_function,avoid_async_callback_in_fake_async,avoid_barrel_files,avoid_bitwise_operators_with_booleans,avoid_bloc_public_fields,avoid_bloc_public_methods,avoid_bottom_type_in_patterns,avoid_bottom_type_in_records,avoid_cascade_after_if_null,avoid_casting_to_extension_type,avoid_collapsible_if,avoid_collection_equality_checks,avoid_collection_methods_with_unrelated_types,avoid_collection_mutating_methods,avoid_commented_out_code,avoid_complex_arithmetic_expressions,avoid_complex_conditions,avoid_complex_loop_conditions,avoid_conditions_with_boolean_literals,avoid_constant_assert_conditions,avoid_constant_conditions,avoid_constant_switches,avoid_continue,avoid_contradictory_expressions,avoid_cubits,avoid_declaring_call_method,avoid_default_tostring,avoid_deprecated_usage,avoid_double_slash_imports,avoid_duplicate_bloc_event_handlers,avoid_duplicate_cascades,avoid_duplicate_collection_elements,avoid_empty_build_when,avoid_empty_setstate,avoid_existing_instances_in_bloc_provider,avoid_instantiating_in_bloc_value_provider,avoid_instantiating_in_value_provider,avoid_late_context,avoid_missing_controller,avoid_mounted_in_setstate,avoid_non_null_assertion,avoid_passing_bloc_to_bloc,avoid_passing_build_context_to_blocs,avoid_read_inside_build,avoid_returning_value_from_cubit_methods,avoid_single_child_column_or_row,avoid_stateless_widget_initialized_fields,avoid_undisposed_instances,avoid_unnecessary_gesture_detector,avoid_unnecessary_overrides_in_state,avoid_unnecessary_stateful_widgets,avoid_watch_outside_build,avoid_wrapping_in_padding,binary_expression_operand_order,check_is_not_closed_after_async_gap,constant_pattern_never_matches_value_type,dead_code,deprecated_member_use,dispose_class_fields,dispose_fields,dispose_providers,double_literal_format,duplicate_ignore,emit_new_bloc_state_instances,equal_elements_in_set,handle_bloc_event_subclasses,must_call_super,newline_before_case,newline_before_constructor,newline_before_method,newline_before_return,no_boolean_literal_compare,no_empty_block,no_empty_string,no_equal_arguments,no_equal_conditions,no_equal_nested_conditions,no_equal_switch_case,no_equal_switch_expression_cases,no_equal_then_else,no_object_declaration,non_exhaustive_switch_expression,not_assigned_potentially_non_nullable_local_variable,pass_existing_future_to_future_builder,pass_existing_stream_to_stream_builder,prefer_action_button_tooltip,prefer_align_over_container,prefer_async_await,prefer_async_callback,prefer_bloc_event_suffix,prefer_bloc_extensions,prefer_bloc_state_suffix,prefer_center_over_align,prefer_compute_over_isolate_run,prefer_constrained_box_over_container,prefer_container,prefer_contains,prefer_correct_bloc_provider,prefer_correct_for_loop_increment,prefer_correct_json_casts,prefer_dedicated_media_query_methods,prefer_first,prefer_for_loop_in_children,prefer_immutable_bloc_events,prefer_immutable_bloc_state,prefer_immutable_selector_value,prefer_iterable_of,prefer_last,prefer_multi_bloc_provider,prefer_multi_provider,prefer_named_boolean_parameters,prefer_nullable_provider_types,prefer_padding_over_container,prefer_provider_extensions,prefer_return_await,prefer_sealed_bloc_events,prefer_sealed_bloc_state,prefer_single_setstate,prefer_sized_box_square,prefer_sliver_prefix,prefer_spacing,prefer_switch_expression,prefer_text_rich,prefer_void_callback,prefer_widget_private_members,proper_super_calls,unchecked_use_of_nullable_value,unnecessary_null_comparison,unused_element,unused_field,unused_import,unused_local_variable

// Test cases that should trigger the prefer_early_return lint

// Case 1: Simple function with entire body wrapped in if
void processItem(String? item) {
  // expect_lint: prefer_early_return
  if (item != null) {
    print('Processing: $item');
  }
}

// Case 2: Function with complex condition
void validateInput(int value) {
  // expect_lint: prefer_early_return
  if (value > 0 && value < 100) {
    print('Valid value: $value');
  }
}

// Case 3: Function with multiple statements in if body
void handleData(List<int> data) {
  // expect_lint: prefer_early_return
  if (data.isNotEmpty) {
    final first = data.first;
    final last = data.last;
    print('First: $first, Last: $last');
  }
}

// Case 4: Async function
Future<void> fetchData(String? url) async {
  // expect_lint: prefer_early_return
  if (url != null) {
    await Future.delayed(Duration(seconds: 1));
    print('Fetched from: $url');
  }
}

// Case 5: Method in a class
class DataProcessor {
  void process(String? data) {
    // expect_lint: prefer_early_return
    if (data != null) {
      print('Processing data: $data');
    }
  }
}

// Case 6: Function returning a value - this is actually good pattern
// (not the "entire body wrapped" pattern that prefer_early_return targets)
int calculate(int? input) {
  if (input != null) {
    return input * 2;
  }
  return 0;
}

// Case 7: Function with negated condition
void checkStatus(bool isReady) {
  // expect_lint: prefer_early_return
  if (!isReady) {
    print('Not ready yet');
  }
}

// Case 8: Function with compound condition
void validateUser(String? name, int? age) {
  // expect_lint: prefer_early_return
  if (name != null && age != null && age > 18) {
    print('Valid user: $name, age $age');
  }
}

// Case 9: Lambda/closure
void testClosure() {
  final handler = (String? value) {
    // expect_lint: prefer_early_return
    if (value != null) {
      print('Handling: $value');
    }
  };
  handler('test');
}

// Case 10: Getter with body wrapped in if
class ConfigManager {
  bool _isEnabled = false;

  void updateConfig(bool value) {
    // expect_lint: prefer_early_return
    if (value != _isEnabled) {
      _isEnabled = value;
      print('Config updated');
    }
  }
}

// Case 11: Function with list check
void printItems(List<String>? items) {
  // expect_lint: prefer_early_return
  if (items != null && items.isNotEmpty) {
    for (final item in items) {
      print(item);
    }
  }
}

// Case 12: Function with equality check
void compareValues(int a, int b) {
  // expect_lint: prefer_early_return
  if (a == b) {
    print('Values are equal');
  }
}
