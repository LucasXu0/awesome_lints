// ignore_for_file: arguments_ordering, avoid_accessing_collections_by_constant_index, avoid_accessing_other_classes_private_members, avoid_adjacent_strings, avoid_always_null_parameters, avoid_assigning_to_static_field, avoid_assignments_as_conditions, avoid_barrel_files, avoid_bitwise_operators_with_booleans, avoid_bottom_type_in_patterns, avoid_bottom_type_in_records, avoid_cascade_after_if_null, avoid_casting_to_extension_type, avoid_collapsible_if, avoid_collection_equality_checks, avoid_collection_methods_with_unrelated_types, avoid_collection_mutating_methods, avoid_commented_out_code, avoid_complex_arithmetic_expressions, avoid_complex_conditions, avoid_complex_loop_conditions, avoid_conditions_with_boolean_literals, avoid_constant_assert_conditions, avoid_constant_conditions, avoid_constant_switches, avoid_continue, avoid_contradictory_expressions, avoid_declaring_call_method, avoid_default_tostring, avoid_deprecated_usage, avoid_double_slash_imports, avoid_duplicate_cascades, avoid_duplicate_collection_elements, avoid_empty_setstate, avoid_late_context, avoid_missing_controller, avoid_mounted_in_setstate, avoid_non_null_assertion, avoid_single_child_column_or_row, avoid_stateless_widget_initialized_fields, avoid_undisposed_instances, avoid_unnecessary_gesture_detector, avoid_unnecessary_overrides_in_state, avoid_unnecessary_stateful_widgets, avoid_wrapping_in_padding, binary_expression_operand_order, dead_code, dispose_class_fields, dispose_fields, double_literal_format, newline_before_case, newline_before_constructor, newline_before_method, newline_before_return, no_boolean_literal_compare, no_empty_block, no_empty_string, no_equal_arguments, no_equal_conditions, no_equal_nested_conditions, no_equal_switch_case, no_equal_switch_expression_cases, no_equal_then_else, no_magic_number, no_magic_string, no_object_declaration, pass_existing_future_to_future_builder, pass_existing_stream_to_stream_builder, prefer_action_button_tooltip, prefer_align_over_container, prefer_async_callback, prefer_center_over_align, prefer_compute_over_isolate_run, prefer_constrained_box_over_container, prefer_container, prefer_dedicated_media_query_methods, prefer_for_loop_in_children, prefer_padding_over_container, prefer_single_setstate, prefer_sized_box_square, prefer_sliver_prefix, prefer_spacing, prefer_text_rich, prefer_void_callback, prefer_widget_private_members, proper_super_calls, unused_element, unused_import, unused_local_variable

// Test cases that should NOT trigger the avoid-async-call-in-sync-function lint

import 'dart:async';

Future<String> asyncFunction() async {
  return 'result';
}

class MyClass {
  Future<int> asyncMethod() async {
    return 42;
  }

  Future<void> asyncWrapper() async {
    // Awaited in async context
    await asyncFunction();
    await asyncMethod();
  }

  void syncMethodWithUnawaited() {
    // Explicitly marked as unawaited
    unawaited(asyncFunction());
    unawaited(asyncMethod());
  }

  void syncMethodWithIgnore() {
    // Using .ignore() extension
    asyncFunction().ignore();
    asyncMethod().ignore();
  }
}

Future<void> asyncTopLevel() async {
  await asyncFunction();
}

void syncWithCallback() {
  // Callback is async
  Future.delayed(Duration(seconds: 1), () async {
    await asyncFunction();
  });
}

// Test FutureBuilder pattern - should not trigger
class FutureBuilder<T> {
  final Future<T> future;
  final void Function(dynamic, dynamic) builder;

  FutureBuilder({required this.future, required this.builder});
}

Future<String> _fetchData() async {
  return 'data';
}

void testFutureBuilder() {
  // Should NOT trigger - future parameter expects a Future
  // Create futures beforehand to avoid pass_existing_future_to_future_builder warning
  // ignore: avoid_async_call_in_sync_function
  final Future<String> dataFuture = _fetchData();
  final widget1 = FutureBuilder<String>(
    future: dataFuture,
    builder: (context, snapshot) {
      return;
    },
  );

  // Should NOT trigger - another async function passed to Future parameter
  // Create futures beforehand to avoid pass_existing_future_to_future_builder warning
  // ignore: avoid_async_call_in_sync_function
  final Future<int> methodFuture = MyClass().asyncMethod();
  final widget2 = FutureBuilder<int>(
    future: methodFuture,
    builder: (context, snapshot) {
      return;
    },
  );

  print(widget1);
  print(widget2);
}

// Test function parameters that expect Future
void functionAcceptingFuture(Future<String> future) {
  print(future);
}

void testFunctionParameter() {
  // Should NOT trigger - parameter expects a Future
  functionAcceptingFuture(asyncFunction());
}

// Note: Assignment to Future-typed variables currently triggers a warning
// This is a known limitation that will be addressed in a future update
