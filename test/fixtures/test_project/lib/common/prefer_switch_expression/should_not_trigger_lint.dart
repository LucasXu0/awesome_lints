// ignore_for_file: arguments_ordering,avoid_accessing_collections_by_constant_index,avoid_accessing_other_classes_private_members,avoid_adjacent_strings,avoid_always_null_parameters,avoid_assigning_to_static_field,avoid_assignments_as_conditions,avoid_async_call_in_sync_function,avoid_async_callback_in_fake_async,avoid_barrel_files,avoid_bitwise_operators_with_booleans,avoid_bloc_public_fields,avoid_bloc_public_methods,avoid_bottom_type_in_patterns,avoid_bottom_type_in_records,avoid_cascade_after_if_null,avoid_casting_to_extension_type,avoid_collapsible_if,avoid_collection_equality_checks,avoid_collection_methods_with_unrelated_types,avoid_collection_mutating_methods,avoid_commented_out_code,avoid_complex_arithmetic_expressions,avoid_complex_conditions,avoid_complex_loop_conditions,avoid_conditions_with_boolean_literals,avoid_constant_assert_conditions,avoid_constant_conditions,avoid_constant_switches,avoid_continue,avoid_contradictory_expressions,avoid_cubits,avoid_declaring_call_method,avoid_default_tostring,avoid_deprecated_usage,avoid_double_slash_imports,avoid_duplicate_bloc_event_handlers,avoid_duplicate_cascades,avoid_duplicate_collection_elements,avoid_empty_build_when,avoid_empty_setstate,avoid_existing_instances_in_bloc_provider,avoid_instantiating_in_bloc_value_provider,avoid_instantiating_in_value_provider,avoid_late_context,avoid_missing_controller,avoid_mounted_in_setstate,avoid_non_null_assertion,avoid_passing_bloc_to_bloc,avoid_passing_build_context_to_blocs,avoid_read_inside_build,avoid_returning_value_from_cubit_methods,avoid_single_child_column_or_row,avoid_stateless_widget_initialized_fields,avoid_undisposed_instances,avoid_unnecessary_gesture_detector,avoid_unnecessary_overrides_in_state,avoid_unnecessary_stateful_widgets,avoid_watch_outside_build,avoid_wrapping_in_padding,binary_expression_operand_order,check_is_not_closed_after_async_gap,constant_pattern_never_matches_value_type,dead_code,deprecated_member_use,dispose_class_fields,dispose_fields,dispose_providers,double_literal_format,duplicate_ignore,emit_new_bloc_state_instances,equal_elements_in_set,handle_bloc_event_subclasses,must_call_super,newline_before_case,newline_before_constructor,newline_before_method,newline_before_return,no_boolean_literal_compare,no_empty_block,no_empty_string,no_equal_arguments,no_equal_conditions,no_equal_nested_conditions,no_equal_switch_case,no_equal_switch_expression_cases,no_equal_then_else,no_object_declaration,non_exhaustive_switch_expression,not_assigned_potentially_non_nullable_local_variable,pass_existing_future_to_future_builder,pass_existing_stream_to_stream_builder,prefer_action_button_tooltip,prefer_align_over_container,prefer_async_await,prefer_async_callback,prefer_bloc_event_suffix,prefer_bloc_extensions,prefer_bloc_state_suffix,prefer_center_over_align,prefer_compute_over_isolate_run,prefer_constrained_box_over_container,prefer_container,prefer_contains,prefer_correct_bloc_provider,prefer_correct_for_loop_increment,prefer_correct_json_casts,prefer_dedicated_media_query_methods,prefer_early_return,prefer_first,prefer_for_loop_in_children,prefer_immutable_bloc_events,prefer_immutable_bloc_state,prefer_immutable_selector_value,prefer_iterable_of,prefer_last,prefer_multi_bloc_provider,prefer_multi_provider,prefer_named_boolean_parameters,prefer_nullable_provider_types,prefer_padding_over_container,prefer_provider_extensions,prefer_return_await,prefer_sealed_bloc_events,prefer_sealed_bloc_state,prefer_single_setstate,prefer_sized_box_square,prefer_sliver_prefix,prefer_spacing,prefer_text_rich,prefer_void_callback,prefer_widget_private_members,proper_super_calls,unchecked_use_of_nullable_value,unnecessary_null_comparison,unused_element,unused_field,unused_import,unused_local_variable

// Already using switch expression (Dart 3.0+)
String alreadySwitchExpression(int value) {
  return switch (value) {
    1 => 'one',
    2 => 'two',
    3 => 'three',
    _ => 'other',
  };
}

// Switch with side effects (can't be converted)
void switchWithSideEffects(int value) {
  switch (value) {
    case 1:
      print('Processing one');
      print('Done');
      break;
    case 2:
      print('Processing two');
      print('Done');
      break;
    default:
      print('Processing other');
      break;
  }
}

// Switch with mixed return and non-return
String mixedReturnBehavior(int value) {
  switch (value) {
    case 1:
      return 'one';
    case 2:
      print('two');
      break;
    case 3:
      return 'three';
    default:
      break;
  }
  return 'default';
}

// Switch with assignment to different variables
void differentAssignmentTargets(int value) {
  var first = '';
  var second = '';

  switch (value) {
    case 1:
      first = 'one';
      break;
    case 2:
      second = 'two';
      break;
    default:
      first = 'other';
      break;
  }

  print('$first $second');
}

// Switch with fall-through cases
void switchWithFallThrough(String input) {
  switch (input) {
    case 'a':
    case 'b':
      print('a or b');
      break;
    case 'c':
      print('c');
      break;
  }
}

// Switch with no return value
void voidReturnSwitch(int value) {
  switch (value) {
    case 1:
      return;
    case 2:
      return;
    default:
      return;
  }
}

// Switch with multiple statements per case
void multipleStatementsPerCase(int value) {
  var result = 0;

  switch (value) {
    case 1:
      final temp = value * 2;
      result = temp + 1;
      break;
    case 2:
      final temp = value * 3;
      result = temp + 2;
      break;
    default:
      result = value;
      break;
  }

  print(result);
}

// Switch with conditional logic inside
String conditionalInsideSwitch(int value) {
  switch (value) {
    case 1:
      if (value > 0) {
        return 'positive one';
      } else {
        return 'negative one';
      }
    case 2:
      return 'two';
    default:
      return 'other';
  }
}

// Switch with try-catch
void switchWithTryCatch(int value) {
  switch (value) {
    case 1:
      try {
        print('Attempting one');
      } catch (e) {
        print('Error: $e');
      }
      break;
    case 2:
      print('two');
      break;
  }
}

// Empty switch statement
void emptySwitch(int value) {
  switch (value) {}
}

// Switch with only one case
void singleCaseSwitch(int value) {
  switch (value) {
    case 1:
      print('only one');
      break;
  }
}

// Switch performing assignments with side effects
void assignmentWithSideEffects(int value) {
  var result = '';

  switch (value) {
    case 1:
      result = getValue1();
      break;
    case 2:
      result = getValue2();
      break;
  }

  print(result);
}

String getValue1() {
  print('Getting value 1');
  return 'one';
}

String getValue2() {
  print('Getting value 2');
  return 'two';
}

// Switch with break without assignment
void breakWithoutAssignment(int value) {
  switch (value) {
    case 1:
      break;
    case 2:
      break;
    default:
      break;
  }
}

// Switch with continue to label
void switchWithContinue(int value) {
  myLoop:
  for (var i = 0; i < 5; i++) {
    switch (value) {
      case 1:
        continue myLoop;
      case 2:
        break;
      default:
        continue myLoop;
    }
  }
}

// Switch with throw statements (not all branches)
String switchWithThrow(int value) {
  switch (value) {
    case 1:
      return 'one';
    case 2:
      throw Exception('Invalid value');
    case 3:
      return 'three';
    default:
      return 'other';
  }
}

// Switch with variable declarations but no assignment/return
void switchWithOnlyDeclarations(int value) {
  switch (value) {
    case 1:
      final x = 1;
      print(x);
      break;
    case 2:
      final y = 2;
      print(y);
      break;
  }
}
