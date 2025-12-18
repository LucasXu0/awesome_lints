// ignore_for_file: arguments_ordering, avoid_accessing_collections_by_constant_index, avoid_accessing_other_classes_private_members, avoid_adjacent_strings, avoid_always_null_parameters, avoid_assigning_to_static_field, avoid_assignments_as_conditions, avoid_async_call_in_sync_function, avoid_barrel_files, avoid_bitwise_operators_with_booleans, avoid_bottom_type_in_patterns, avoid_bottom_type_in_records, avoid_cascade_after_if_null, avoid_casting_to_extension_type, avoid_collapsible_if, avoid_collection_equality_checks, avoid_collection_methods_with_unrelated_types, avoid_collection_mutating_methods, avoid_commented_out_code, avoid_complex_arithmetic_expressions, avoid_complex_conditions, avoid_complex_loop_conditions, avoid_conditions_with_boolean_literals, avoid_constant_assert_conditions, avoid_constant_conditions, avoid_constant_switches, avoid_continue, avoid_contradictory_expressions, avoid_declaring_call_method, avoid_default_tostring, avoid_deprecated_usage, avoid_double_slash_imports, avoid_duplicate_cascades, avoid_duplicate_collection_elements, avoid_empty_setstate, avoid_late_context, avoid_missing_controller, avoid_mounted_in_setstate, avoid_non_null_assertion, avoid_single_child_column_or_row, avoid_stateless_widget_initialized_fields, avoid_undisposed_instances, avoid_unnecessary_gesture_detector, avoid_unnecessary_overrides_in_state, avoid_unnecessary_stateful_widgets, avoid_wrapping_in_padding, binary_expression_operand_order, dead_code, dispose_class_fields, dispose_fields, double_literal_format, newline_before_case, newline_before_constructor, newline_before_return, no_boolean_literal_compare, no_empty_block, no_empty_string, no_equal_arguments, no_equal_conditions, no_equal_nested_conditions, no_equal_switch_case, no_equal_switch_expression_cases, no_equal_then_else, no_magic_number, no_magic_string, no_object_declaration, pass_existing_future_to_future_builder, pass_existing_stream_to_stream_builder, prefer_action_button_tooltip, prefer_align_over_container, prefer_async_callback, prefer_center_over_align, prefer_compute_over_isolate_run, prefer_constrained_box_over_container, prefer_container, prefer_dedicated_media_query_methods, prefer_for_loop_in_children, prefer_padding_over_container, prefer_single_setstate, prefer_sized_box_square, prefer_sliver_prefix, prefer_spacing, prefer_text_rich, prefer_void_callback, prefer_widget_private_members, proper_super_calls, unused_element, unused_import, unused_local_variable

// First method in class - no lint
class FirstMethodNoLint {
  void firstMethod() {}
}

// Proper spacing between methods
class ProperSpacing {
  void firstMethod() {}

  void secondMethod() {}

  void thirdMethod() {}
}

// Proper spacing with fields
class ProperSpacingWithFields {
  int field = 0;

  void method() {}
}

// Multiple fields then method with spacing
class MultipleFieldsThenMethod {
  String name = 'test';
  int age = 25;

  void printInfo() {
    print('$name, $age');
  }
}

// Constructor as first member
class ConstructorFirst {
  ConstructorFirst();

  void method() {}
}

// Proper spacing with getters and setters
class GettersSettersAndMethods {
  String _value = '';

  String get value => _value;

  set value(String v) => _value = v;

  void useValue() {
    print(value);
  }
}

// Single method only
class SingleMethod {
  void onlyMethod() {}
}

// Static and instance with proper spacing
class StaticAndInstanceProper {
  static void staticMethod() {}

  void instanceMethod() {}
}

// Async methods with proper spacing
class AsyncMethodsProper {
  Future<void> first() async {}

  Future<void> second() async {}

  Future<void> third() async {}
}

// Generic methods with proper spacing
class GenericMethodsProper {
  T identity<T>(T value) => value;

  List<T> toList<T>(T value) => [value];
}

// Mixed member types with proper spacing
class AllMemberTypes {
  // Field
  int field = 0;

  // Constructor
  AllMemberTypes();

  // Getter
  int get doubled => field * 2;

  // Setter
  set doubled(int value) => field = value ~/ 2;

  // Static method
  static void staticMethod() {}

  // Instance method
  void instanceMethod() {}

  // Private method
  void _privateMethod() {}
}

// Expression body methods
class ExpressionBodyMethods {
  int getValue() => 42;

  String getName() => 'test';
}
