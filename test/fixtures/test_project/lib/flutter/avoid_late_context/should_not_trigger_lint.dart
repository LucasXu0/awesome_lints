// ignore_for_file: arguments_ordering, avoid_accessing_collections_by_constant_index, avoid_accessing_other_classes_private_members, avoid_adjacent_strings, avoid_always_null_parameters, avoid_assigning_to_static_field, avoid_assignments_as_conditions, avoid_async_call_in_sync_function, avoid_barrel_files, avoid_bitwise_operators_with_booleans
// ignore_for_file: avoid_bottom_type_in_patterns, avoid_bottom_type_in_records, avoid_cascade_after_if_null, avoid_casting_to_extension_type, avoid_collapsible_if, avoid_collection_equality_checks, avoid_collection_methods_with_unrelated_types, avoid_collection_mutating_methods, avoid_commented_out_code, avoid_complex_arithmetic_expressions
// ignore_for_file: avoid_complex_conditions, avoid_complex_loop_conditions, avoid_conditions_with_boolean_literals, avoid_constant_assert_conditions, avoid_constant_conditions, avoid_constant_switches, avoid_continue, avoid_contradictory_expressions, avoid_declaring_call_method, avoid_default_tostring
// ignore_for_file: avoid_deprecated_usage, avoid_double_slash_imports, avoid_duplicate_cascades, avoid_duplicate_collection_elements, avoid_empty_setstate, avoid_missing_controller, avoid_mounted_in_setstate, avoid_non_null_assertion, avoid_single_child_column_or_row, avoid_stateless_widget_initialized_fields
// ignore_for_file: avoid_undisposed_instances, avoid_unnecessary_gesture_detector, avoid_unnecessary_overrides_in_state, avoid_unnecessary_stateful_widgets, avoid_wrapping_in_padding, binary_expression_operand_order, dispose_class_fields, dispose_fields, double_literal_format, newline_before_case
// ignore_for_file: newline_before_constructor, newline_before_method, newline_before_return, no_boolean_literal_compare, no_empty_block, no_empty_string, no_equal_arguments, no_equal_conditions, no_equal_nested_conditions, no_equal_switch_case
// ignore_for_file: no_equal_switch_expression_cases, no_equal_then_else, no_magic_number, no_magic_string, no_object_declaration, pass_existing_future_to_future_builder, pass_existing_stream_to_stream_builder, prefer_action_button_tooltip, prefer_align_over_container, prefer_async_callback
// ignore_for_file: prefer_center_over_align, prefer_compute_over_isolate_run, prefer_constrained_box_over_container, prefer_container, prefer_dedicated_media_query_methods, prefer_for_loop_in_children, prefer_padding_over_container, prefer_single_setstate, prefer_sized_box_square, prefer_sliver_prefix
// ignore_for_file: prefer_spacing, prefer_text_rich, prefer_void_callback, prefer_widget_private_members, proper_super_calls

import 'package:flutter/material.dart';

// ignore_for_file: unused_field, prefer_const_constructors

class ShouldNotTriggerLint extends StatefulWidget {
  const ShouldNotTriggerLint({super.key});

  @override
  State<ShouldNotTriggerLint> createState() => _ShouldNotTriggerLintState();
}

class _ShouldNotTriggerLintState extends State<ShouldNotTriggerLint> {
  // Case 1: Late field without context - should NOT trigger
  late final _value = _getValue();

  // Case 2: Late field with constant - should NOT trigger
  late final _constant = 'constant value';

  // Case 3: Late field without initializer - should NOT trigger
  late final String _noInit;

  // Case 4: Non-late field with context - should NOT trigger
  final _nonLateContext = null;

  // Case 5: Late field with other identifier named 'context' - should NOT trigger
  // (This is a variable named context, not BuildContext)
  late final _otherContext = _getContext();

  String _getValue() {
    return 'value';
  }

  String _getContext() {
    return 'not a BuildContext';
  }

  @override
  void initState() {
    super.initState();
    _noInit = 'initialized in initState';
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 6: Late field with context in non-State class - should NOT trigger
class NotAStateClass {
  late final _value = _create();

  String _create() {
    return 'value';
  }
}
