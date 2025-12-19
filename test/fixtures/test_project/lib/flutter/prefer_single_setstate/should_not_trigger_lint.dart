// ignore_for_file: arguments_ordering, avoid_accessing_collections_by_constant_index, avoid_accessing_other_classes_private_members, avoid_adjacent_strings, avoid_always_null_parameters, avoid_assigning_to_static_field, avoid_assignments_as_conditions, avoid_async_call_in_sync_function, avoid_barrel_files, avoid_bitwise_operators_with_booleans, avoid_bottom_type_in_patterns, avoid_bottom_type_in_records, avoid_cascade_after_if_null, avoid_casting_to_extension_type, avoid_collapsible_if, avoid_collection_equality_checks, avoid_collection_methods_with_unrelated_types, avoid_collection_mutating_methods, avoid_commented_out_code, avoid_complex_arithmetic_expressions, avoid_complex_conditions, avoid_complex_loop_conditions, avoid_conditions_with_boolean_literals, avoid_constant_assert_conditions, avoid_constant_conditions, avoid_constant_switches, avoid_continue, avoid_contradictory_expressions, avoid_declaring_call_method, avoid_default_tostring, avoid_deprecated_usage, avoid_double_slash_imports, avoid_duplicate_cascades, avoid_duplicate_collection_elements, avoid_empty_setstate, avoid_late_context, avoid_missing_controller, avoid_mounted_in_setstate, avoid_non_null_assertion, avoid_single_child_column_or_row, avoid_stateless_widget_initialized_fields, avoid_undisposed_instances, avoid_unnecessary_gesture_detector, avoid_unnecessary_overrides_in_state, avoid_unnecessary_stateful_widgets, avoid_wrapping_in_padding, binary_expression_operand_order, dead_code, dispose_class_fields, dispose_fields, double_literal_format, newline_before_case, newline_before_constructor, newline_before_method, newline_before_return, no_boolean_literal_compare, no_empty_block, no_empty_string, no_equal_arguments, no_equal_conditions, no_equal_nested_conditions, no_equal_switch_case, no_equal_switch_expression_cases, no_equal_then_else, no_magic_number, no_magic_string, no_object_declaration, pass_existing_future_to_future_builder, pass_existing_stream_to_stream_builder, prefer_action_button_tooltip, prefer_align_over_container, prefer_async_callback, prefer_center_over_align, prefer_compute_over_isolate_run, prefer_constrained_box_over_container, prefer_container, prefer_dedicated_media_query_methods, prefer_for_loop_in_children, prefer_padding_over_container, prefer_sized_box_square, prefer_sliver_prefix, prefer_spacing, prefer_text_rich, prefer_void_callback, prefer_widget_private_members, proper_super_calls, unused_element, unused_field, unused_import, unused_local_variable

import 'package:flutter/material.dart';

class ShouldNotTriggerLint extends StatefulWidget {
  const ShouldNotTriggerLint({super.key});

  @override
  State<ShouldNotTriggerLint> createState() => _ShouldNotTriggerLintState();
}

class _ShouldNotTriggerLintState extends State<ShouldNotTriggerLint> {
  int _counter = 0;
  String _message = '';
  bool _isLoading = false;

  // Case 1: Single setState call - should NOT trigger
  void _singleSetState() {
    setState(() {
      _counter++;
    });
  }

  // Case 2: setState calls separated by other logic - should NOT trigger
  void _setStateWithLogicBetween() {
    setState(() {
      _counter++;
    });
    print('Counter updated');
    setState(() {
      _message = 'Updated';
    });
  }

  // Case 3: setState in different control flow branches - should NOT trigger
  void _setStateInDifferentBranches() {
    if (_counter > 0) {
      setState(() {
        _counter--;
      });
    } else {
      setState(() {
        _counter++;
      });
    }
  }

  // Case 4: setState calls in different if blocks - should NOT trigger
  void _setStateInSeparateIfBlocks() {
    if (_counter > 5) {
      setState(() {
        _message = 'High';
      });
    }

    if (_isLoading) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Case 5: setState in loop - should NOT trigger
  void _setStateInLoop() {
    for (var i = 0; i < 3; i++) {
      setState(() {
        _counter++;
      });
    }
  }

  // Case 6: setState separated by variable declaration - should NOT trigger
  void _setStateWithDeclarationBetween() {
    setState(() {
      _counter++;
    });
    final newMessage = 'Counter is $_counter';
    setState(() {
      _message = newMessage;
    });
  }

  // Case 7: setState separated by function call - should NOT trigger
  void _setStateWithFunctionCallBetween() {
    setState(() {
      _counter = 0;
    });
    _logReset();
    setState(() {
      _message = 'Reset';
    });
  }

  void _logReset() {
    print('Reset called');
  }

  // Case 8: setState in switch statement - should NOT trigger
  void _setStateInSwitch(int value) {
    switch (value) {
      case 1:
        setState(() {
          _counter = 1;
        });
        break;

      case 2:
        setState(() {
          _counter = 2;
        });
        break;
    }
  }

  // Case 9: setState in while loop - should NOT trigger
  void _setStateInWhile() {
    var i = 0;
    while (i < 3) {
      setState(() {
        _counter++;
      });
      i++;
    }
  }

  // Case 10: No setState calls - should NOT trigger
  void _noSetState() {
    _counter++;
    _message = 'No setState';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Test')),
      body: Center(
        child: Column(
          children: [Text('Counter: $_counter'), Text('Message: $_message')],
        ),
      ),
    );
  }
}
