// ignore_for_file: arguments_ordering, avoid_async_call_in_sync_function, avoid_bloc_public_fields, avoid_bloc_public_methods, avoid_cubits, avoid_default_tostring, avoid_duplicate_bloc_event_handlers, avoid_duplicate_collection_elements, avoid_empty_build_when, avoid_existing_instances_in_bloc_provider, avoid_instantiating_in_bloc_value_provider, avoid_passing_bloc_to_bloc, avoid_passing_build_context_to_blocs, avoid_returning_value_from_cubit_methods, avoid_unnecessary_stateful_widgets, check_is_not_closed_after_async_gap, dispose_providers, emit_new_bloc_state_instances, handle_bloc_event_subclasses, newline_before_constructor, newline_before_method, no_empty_block, no_empty_string, prefer_async_await, prefer_bloc_event_suffix, prefer_bloc_extensions, prefer_bloc_state_suffix, prefer_contains, prefer_correct_bloc_provider, prefer_correct_for_loop_increment, prefer_early_return, prefer_immutable_bloc_state, prefer_iterable_of, prefer_multi_bloc_provider, prefer_multi_provider, prefer_named_boolean_parameters, prefer_sealed_bloc_events, prefer_sealed_bloc_state, prefer_switch_expression, prefer_widget_private_members, unused_element, unused_field, unused_local_variable

import 'package:flutter/foundation.dart';

// Event with @immutable annotation - should not trigger lint
@immutable
sealed class CounterEvent {
  const CounterEvent();
}

@immutable
final class IncrementEvent extends CounterEvent {
  const IncrementEvent();
}

@immutable
final class DecrementEvent extends CounterEvent {
  const DecrementEvent();
}

// Another event with @immutable
@immutable
sealed class UserEvent {
  const UserEvent();
}

@immutable
final class LoadUserEvent extends UserEvent {
  final String userId;
  const LoadUserEvent(this.userId);
}

// Events with @immutable
@immutable
sealed class AuthEvent {
  const AuthEvent();
}

@immutable
final class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  const LoginEvent(this.username, this.password);
}

@immutable
final class LogoutEvent extends AuthEvent {
  const LogoutEvent();
}

// Classes not ending with Event are ignored
class RegularClass {}
