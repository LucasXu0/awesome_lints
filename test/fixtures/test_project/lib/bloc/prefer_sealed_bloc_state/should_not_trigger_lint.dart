// ignore_for_file: prefer_immutable_bloc_events, prefer_immutable_bloc_state, prefer_sealed_bloc_events, handle_bloc_event_subclasses, avoid_cubits, avoid_bloc_public_fields, avoid_bloc_public_methods, prefer_bloc_event_suffix, prefer_bloc_state_suffix, avoid_returning_value_from_cubit_methods, avoid_passing_build_context_to_blocs, unused_element, unused_field, unused_local_variable, prefer_widget_private_members, newline_before_method, newline_before_constructor, avoid_duplicate_bloc_event_handlers, avoid_empty_build_when, avoid_existing_instances_in_bloc_provider, avoid_instantiating_in_bloc_value_provider, avoid_passing_bloc_to_bloc, check_is_not_closed_after_async_gap, emit_new_bloc_state_instances, prefer_bloc_extensions, prefer_correct_bloc_provider, prefer_multi_bloc_provider, no_empty_string, avoid_async_call_in_sync_function, avoid_default_tostring, no_empty_block, arguments_ordering, dispose_providers, avoid_unnecessary_stateful_widgets, prefer_multi_provider, avoid_duplicate_collection_elements

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
