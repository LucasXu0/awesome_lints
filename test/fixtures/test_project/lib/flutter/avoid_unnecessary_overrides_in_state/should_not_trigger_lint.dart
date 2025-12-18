// ignore_for_file: arguments_ordering, avoid_accessing_collections_by_constant_index, avoid_accessing_other_classes_private_members, avoid_adjacent_strings, avoid_always_null_parameters, avoid_assigning_to_static_field, avoid_assignments_as_conditions, avoid_async_call_in_sync_function, avoid_barrel_files, avoid_bitwise_operators_with_booleans
// ignore_for_file: avoid_bottom_type_in_patterns, avoid_bottom_type_in_records, avoid_cascade_after_if_null, avoid_casting_to_extension_type, avoid_collapsible_if, avoid_collection_equality_checks, avoid_collection_methods_with_unrelated_types, avoid_collection_mutating_methods, avoid_commented_out_code, avoid_complex_arithmetic_expressions
// ignore_for_file: avoid_complex_conditions, avoid_complex_loop_conditions, avoid_conditions_with_boolean_literals, avoid_constant_assert_conditions, avoid_constant_conditions, avoid_constant_switches, avoid_continue, avoid_contradictory_expressions, avoid_declaring_call_method, avoid_default_tostring
// ignore_for_file: avoid_deprecated_usage, avoid_double_slash_imports, avoid_duplicate_cascades, avoid_duplicate_collection_elements, avoid_empty_setstate, avoid_late_context, avoid_missing_controller, avoid_mounted_in_setstate, avoid_non_null_assertion, avoid_single_child_column_or_row
// ignore_for_file: avoid_stateless_widget_initialized_fields, avoid_undisposed_instances, avoid_unnecessary_gesture_detector, avoid_unnecessary_stateful_widgets, avoid_wrapping_in_padding, binary_expression_operand_order, dispose_class_fields, dispose_fields, double_literal_format, newline_before_case
// ignore_for_file: newline_before_constructor, newline_before_method, newline_before_return, no_boolean_literal_compare, no_empty_block, no_empty_string, no_equal_arguments, no_equal_conditions, no_equal_nested_conditions, no_equal_switch_case
// ignore_for_file: no_equal_switch_expression_cases, no_equal_then_else, no_magic_number, no_magic_string, no_object_declaration, pass_existing_future_to_future_builder, pass_existing_stream_to_stream_builder, prefer_action_button_tooltip, prefer_align_over_container, prefer_async_callback
// ignore_for_file: prefer_center_over_align, prefer_compute_over_isolate_run, prefer_constrained_box_over_container, prefer_container, prefer_dedicated_media_query_methods, prefer_for_loop_in_children, prefer_padding_over_container, prefer_single_setstate, prefer_sized_box_square, prefer_sliver_prefix
// ignore_for_file: prefer_spacing, prefer_text_rich, prefer_void_callback, prefer_widget_private_members, proper_super_calls

import 'package:flutter/material.dart';

// ignore_for_file: unused_field, must_call_super

// Case 1: dispose() with additional logic - should NOT trigger
class MyWidget1 extends StatefulWidget {
  const MyWidget1({super.key});

  @override
  State<MyWidget1> createState() => _MyWidget1State();
}

class _MyWidget1State extends State<MyWidget1> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 2: initState() with additional logic - should NOT trigger
class MyWidget2 extends StatefulWidget {
  const MyWidget2({super.key});

  @override
  State<MyWidget2> createState() => _MyWidget2State();
}

class _MyWidget2State extends State<MyWidget2> {
  @override
  void initState() {
    super.initState();
    // Additional initialization
    print('Initialized');
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 3: didUpdateWidget with additional logic - should NOT trigger
class MyWidget3 extends StatefulWidget {
  const MyWidget3({super.key});

  @override
  State<MyWidget3> createState() => _MyWidget3State();
}

class _MyWidget3State extends State<MyWidget3> {
  @override
  void didUpdateWidget(MyWidget3 oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Check for changes
    print('Widget updated');
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 4: Method with @protected annotation but has logic - should NOT trigger
class MyWidget4 extends StatefulWidget {
  const MyWidget4({super.key});

  @override
  State<MyWidget4> createState() => _MyWidget4State();
}

class _MyWidget4State extends State<MyWidget4> {
  @override
  @protected
  void dispose() {
    // Even with @protected, this has logic so should NOT trigger
    print('Cleaning up');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 5: Not a State class - should NOT trigger
class RegularClass {
  @override
  String toString() {
    return super.toString();
  }
}

// Case 6: Override with different logic - should NOT trigger
class MyWidget6 extends StatefulWidget {
  const MyWidget6({super.key});

  @override
  State<MyWidget6> createState() => _MyWidget6State();
}

class _MyWidget6State extends State<MyWidget6> {
  @override
  void didChangeDependencies() {
    // Different implementation
    print('Dependencies changed');
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Case 7: Method without override annotation - should NOT trigger
class MyWidget7 extends StatefulWidget {
  const MyWidget7({super.key});

  @override
  State<MyWidget7> createState() => _MyWidget7State();
}

class _MyWidget7State extends State<MyWidget7> {
  // This method is not marked as @override, so it won't be checked
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
