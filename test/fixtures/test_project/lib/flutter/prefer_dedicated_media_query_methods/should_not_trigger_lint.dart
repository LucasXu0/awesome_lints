// ignore_for_file: arguments_ordering, avoid_accessing_collections_by_constant_index, avoid_accessing_other_classes_private_members, avoid_adjacent_strings, avoid_always_null_parameters, avoid_assigning_to_static_field, avoid_assignments_as_conditions, avoid_async_call_in_sync_function, avoid_barrel_files, avoid_bitwise_operators_with_booleans, avoid_bottom_type_in_patterns, avoid_bottom_type_in_records, avoid_cascade_after_if_null, avoid_casting_to_extension_type, avoid_collapsible_if, avoid_collection_equality_checks, avoid_collection_methods_with_unrelated_types, avoid_collection_mutating_methods, avoid_commented_out_code, avoid_complex_arithmetic_expressions, avoid_complex_conditions, avoid_complex_loop_conditions, avoid_conditions_with_boolean_literals, avoid_constant_assert_conditions, avoid_constant_conditions, avoid_constant_switches, avoid_continue, avoid_contradictory_expressions, avoid_declaring_call_method, avoid_default_tostring, avoid_deprecated_usage, avoid_double_slash_imports, avoid_duplicate_cascades, avoid_duplicate_collection_elements, avoid_empty_setstate, avoid_late_context, avoid_missing_controller, avoid_mounted_in_setstate, avoid_non_null_assertion, avoid_single_child_column_or_row, avoid_stateless_widget_initialized_fields, avoid_undisposed_instances, avoid_unnecessary_gesture_detector, avoid_unnecessary_overrides_in_state, avoid_unnecessary_stateful_widgets, avoid_wrapping_in_padding, binary_expression_operand_order, dead_code, dispose_class_fields, dispose_fields, double_literal_format, newline_before_case, newline_before_constructor, newline_before_method, newline_before_return, no_boolean_literal_compare, no_empty_block, no_empty_string, no_equal_arguments, no_equal_conditions, no_equal_nested_conditions, no_equal_switch_case, no_equal_switch_expression_cases, no_equal_then_else, no_magic_number, no_magic_string, no_object_declaration, pass_existing_future_to_future_builder, pass_existing_stream_to_stream_builder, prefer_action_button_tooltip, prefer_align_over_container, prefer_async_await, prefer_async_callback, prefer_center_over_align, prefer_compute_over_isolate_run, prefer_constrained_box_over_container, prefer_container, prefer_contains, prefer_correct_for_loop_increment, prefer_early_return, prefer_for_loop_in_children, prefer_iterable_of, prefer_named_boolean_parameters, prefer_padding_over_container, prefer_single_setstate, prefer_sized_box_square, prefer_sliver_prefix, prefer_spacing, prefer_switch_expression, prefer_text_rich, prefer_void_callback, prefer_widget_private_members, proper_super_calls, unused_element, unused_import, unused_local_variable

import 'package:flutter/material.dart';

class ShouldNotTriggerLint extends StatelessWidget {
  const ShouldNotTriggerLint({super.key});

  @override
  Widget build(BuildContext context) {
    // Case 1: MediaQuery.sizeOf() - should NOT trigger
    final size = MediaQuery.sizeOf(context);

    // Case 2: MediaQuery.maybeSizeOf() - should NOT trigger
    final maybeSize = MediaQuery.maybeSizeOf(context);

    // Case 3: MediaQuery.paddingOf() - should NOT trigger
    final padding = MediaQuery.paddingOf(context);

    // Case 4: MediaQuery.maybePaddingOf() - should NOT trigger
    final maybePadding = MediaQuery.maybePaddingOf(context);

    // Case 5: MediaQuery.viewInsetsOf() - should NOT trigger
    final viewInsets = MediaQuery.viewInsetsOf(context);

    // Case 6: MediaQuery.maybeViewInsetsOf() - should NOT trigger
    final maybeViewInsets = MediaQuery.maybeViewInsetsOf(context);

    // Case 7: MediaQuery.viewPaddingOf() - should NOT trigger
    final viewPadding = MediaQuery.viewPaddingOf(context);

    // Case 8: MediaQuery.maybeViewPaddingOf() - should NOT trigger
    final maybeViewPadding = MediaQuery.maybeViewPaddingOf(context);

    // Case 9: MediaQuery.devicePixelRatioOf() - should NOT trigger
    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);

    // Case 10: MediaQuery.maybeDevicePixelRatioOf() - should NOT trigger
    final maybeDevicePixelRatio = MediaQuery.maybeDevicePixelRatioOf(context);

    // Case 11: MediaQuery.textScalerOf() - should NOT trigger
    final textScale = MediaQuery.textScalerOf(context);

    // Case 12: MediaQuery.maybeTextScalerOf() - should NOT trigger
    final maybeTextScale = MediaQuery.maybeTextScalerOf(context);

    // Case 13: MediaQuery.platformBrightnessOf() - should NOT trigger
    final brightness = MediaQuery.platformBrightnessOf(context);

    // Case 14: MediaQuery.maybePlatformBrightnessOf() - should NOT trigger
    final maybeBrightness = MediaQuery.maybePlatformBrightnessOf(context);

    // Case 15: MediaQuery.highContrastOf() - should NOT trigger
    final highContrast = MediaQuery.highContrastOf(context);

    // Case 16: MediaQuery.maybeHighContrastOf() - should NOT trigger
    final maybeHighContrast = MediaQuery.maybeHighContrastOf(context);

    // Case 17: MediaQuery.boldTextOf() - should NOT trigger
    final boldText = MediaQuery.boldTextOf(context);

    // Case 18: MediaQuery.maybeBoldTextOf() - should NOT trigger
    final maybeBoldText = MediaQuery.maybeBoldTextOf(context);

    // Case 19: MediaQuery.orientationOf() - should NOT trigger
    final orientation = MediaQuery.orientationOf(context);

    // Case 20: MediaQuery.maybeOrientationOf() - should NOT trigger
    final maybeOrientation = MediaQuery.maybeOrientationOf(context);

    return Container();
  }
}

class AnotherExample extends StatelessWidget {
  const AnotherExample({super.key});

  @override
  Widget build(BuildContext context) {
    // Case 21: Using sizeOf in conditional - should NOT trigger
    if (MediaQuery.sizeOf(context).width > 600) {
      return Container();
    }

    // Case 22: Using platformBrightnessOf with equality - should NOT trigger
    if (MediaQuery.platformBrightnessOf(context) == Brightness.dark) {
      return Container();
    }

    // Case 23: Using textScalerOf in calculation - should NOT trigger
    final fontSize = MediaQuery.textScalerOf(context).scale(14);

    return Container();
  }
}

// Case 24: Not MediaQuery at all - should NOT trigger
class CustomMediaQuery {
  static CustomMediaQuery of(BuildContext context) {
    return CustomMediaQuery();
  }

  static CustomMediaQuery? maybeOf(BuildContext context) {
    return null;
  }
}

class UsingCustomMediaQuery extends StatelessWidget {
  const UsingCustomMediaQuery({super.key});

  @override
  Widget build(BuildContext context) {
    // Should NOT trigger - different class
    final custom1 = CustomMediaQuery.of(context);
    final custom2 = CustomMediaQuery.maybeOf(context);

    return Container();
  }
}
