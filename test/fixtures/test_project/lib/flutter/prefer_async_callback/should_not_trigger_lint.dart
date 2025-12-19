// ignore_for_file: arguments_ordering, avoid_accessing_collections_by_constant_index, avoid_accessing_other_classes_private_members, avoid_adjacent_strings, avoid_always_null_parameters, avoid_assigning_to_static_field, avoid_assignments_as_conditions, avoid_async_call_in_sync_function, avoid_barrel_files, avoid_bitwise_operators_with_booleans, avoid_bottom_type_in_patterns, avoid_bottom_type_in_records, avoid_cascade_after_if_null, avoid_casting_to_extension_type, avoid_collapsible_if, avoid_collection_equality_checks, avoid_collection_methods_with_unrelated_types, avoid_collection_mutating_methods, avoid_commented_out_code, avoid_complex_arithmetic_expressions, avoid_complex_conditions, avoid_complex_loop_conditions, avoid_conditions_with_boolean_literals, avoid_constant_assert_conditions, avoid_constant_conditions, avoid_constant_switches, avoid_continue, avoid_contradictory_expressions, avoid_declaring_call_method, avoid_default_tostring, avoid_deprecated_usage, avoid_double_slash_imports, avoid_duplicate_cascades, avoid_duplicate_collection_elements, avoid_empty_setstate, avoid_late_context, avoid_missing_controller, avoid_mounted_in_setstate, avoid_non_null_assertion, avoid_single_child_column_or_row, avoid_stateless_widget_initialized_fields, avoid_undisposed_instances, avoid_unnecessary_gesture_detector, avoid_unnecessary_overrides_in_state, avoid_unnecessary_stateful_widgets, avoid_wrapping_in_padding, binary_expression_operand_order, dead_code, dispose_class_fields, dispose_fields, double_literal_format, newline_before_case, newline_before_constructor, newline_before_method, newline_before_return, no_boolean_literal_compare, no_empty_block, no_empty_string, no_equal_arguments, no_equal_conditions, no_equal_nested_conditions, no_equal_switch_case, no_equal_switch_expression_cases, no_equal_then_else, no_magic_number, no_magic_string, no_object_declaration, pass_existing_future_to_future_builder, pass_existing_stream_to_stream_builder, prefer_action_button_tooltip, prefer_align_over_container, prefer_center_over_align, prefer_compute_over_isolate_run, prefer_constrained_box_over_container, prefer_container, prefer_dedicated_media_query_methods, prefer_for_loop_in_children, prefer_padding_over_container, prefer_single_setstate, prefer_sized_box_square, prefer_sliver_prefix, prefer_spacing, prefer_text_rich, prefer_void_callback, prefer_widget_private_members, proper_super_calls, unused_element, unused_import, unused_local_variable

import 'package:flutter/foundation.dart';

/// Test cases where prefer_async_callback lint should NOT trigger

// Case 1: Using AsyncCallback typedef (correct usage)
void functionWithAsyncCallback(AsyncCallback callback) {
  callback();
}

// Case 2: Variable with AsyncCallback
void variableWithAsyncCallback() {
  final AsyncCallback callback = () async {};
  AsyncCallback? nullableCallback;
}

// Case 3: Return type as AsyncCallback
AsyncCallback returnAsyncCallback() {
  return () async {};
}

// Case 4: Generic type with AsyncCallback
void genericTypesWithAsyncCallback() {
  final List<AsyncCallback> callbacks = [];
  final Map<String, AsyncCallback> callbackMap = {};
}

// Case 5: Class field with AsyncCallback
class MyClass {
  final AsyncCallback? onPressed;
  AsyncCallback callback = () async {};

  MyClass(this.onPressed);
}

// Case 6: Future<void> Function with parameters (should NOT trigger)
void functionWithParameters(Future<void> Function(int) callback) {
  callback(42);
}

// Case 7: Future<void> Function with multiple parameters (should NOT trigger)
void functionWithMultipleParameters(
  Future<void> Function(String, int) callback,
) {
  callback('hello', 42);
}

// Case 8: Function returning non-void Future (should NOT trigger)
void functionReturningValue(Future<int> Function() callback) {
  callback();
}

// Case 9: Optional parameters with AsyncCallback
void optionalParametersWithAsyncCallback([AsyncCallback? callback]) {
  callback?.call();
}

// Case 10: Named parameters with AsyncCallback
void namedParametersWithAsyncCallback({AsyncCallback? onComplete}) {
  onComplete?.call();
}

// Case 11: Generic function with parameters (should NOT trigger)
void genericWithParameters() {
  final List<Future<void> Function(int)> callbacks = [];
}

// Case 12: Function with named parameters (should NOT trigger)
void functionWithNamedParams(Future<void> Function({String? name}) callback) {
  callback(name: 'test');
}

// Case 13: Synchronous void Function() (should NOT trigger)

void synchronousCallback(void Function() callback) {
  callback();
}

// Case 14: Future without type argument (should NOT trigger)
void futureWithoutTypeArg(Future Function() callback) {
  callback();
}

// Case 15: Future<String> (should NOT trigger)
void futureString(Future<String> Function() callback) {
  callback();
}
