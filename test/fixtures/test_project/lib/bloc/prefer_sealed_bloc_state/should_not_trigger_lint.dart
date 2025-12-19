// ignore_for_file: arguments_ordering, avoid_async_call_in_sync_function, avoid_bloc_public_fields, avoid_bloc_public_methods, avoid_cubits, avoid_default_tostring, avoid_duplicate_bloc_event_handlers, avoid_duplicate_collection_elements, avoid_empty_build_when, avoid_existing_instances_in_bloc_provider, avoid_instantiating_in_bloc_value_provider, avoid_passing_bloc_to_bloc, avoid_passing_build_context_to_blocs, avoid_returning_value_from_cubit_methods, avoid_unnecessary_stateful_widgets, check_is_not_closed_after_async_gap, dispose_providers, emit_new_bloc_state_instances, handle_bloc_event_subclasses, newline_before_constructor, newline_before_method, no_empty_block, no_empty_string, prefer_async_await, prefer_bloc_event_suffix, prefer_bloc_extensions, prefer_bloc_state_suffix, prefer_contains, prefer_correct_bloc_provider, prefer_correct_for_loop_increment, prefer_early_return, prefer_immutable_bloc_events, prefer_immutable_bloc_state, prefer_iterable_of, prefer_multi_bloc_provider, prefer_multi_provider, prefer_named_boolean_parameters, prefer_sealed_bloc_events, prefer_switch_expression, prefer_widget_private_members, unused_element, unused_field, unused_local_variable

import 'package:flutter/widgets.dart';

// State with sealed modifier - should not trigger lint
sealed class CounterState {
  const CounterState();
}

final class CounterInitial extends CounterState {
  const CounterInitial();
}

final class CounterValue extends CounterState {
  final int value;
  const CounterValue(this.value);
}

// State with final modifier
final class SingleState {
  const SingleState();
}

// State with abstract modifier
abstract class BaseState {
  const BaseState();
}

final class ConcreteState extends BaseState {
  const ConcreteState();
}

// Sealed state hierarchy
sealed class UserState {
  const UserState();
}

final class UserInitial extends UserState {
  const UserInitial();
}

final class UserLoaded extends UserState {
  final String name;
  const UserLoaded(this.name);
}

final class UserError extends UserState {
  final String message;
  const UserError(this.message);
}

// Final concrete states
final class AuthInitialState {
  const AuthInitialState();
}

final class AuthLoadingState {
  const AuthLoadingState();
}

final class AuthSuccessState {
  final String token;
  const AuthSuccessState(this.token);
}

// Flutter State class should be ignored
class MyWidgetState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Classes not ending with State are ignored
class RegularClass {}

sealed class NotAState {}
