// ignore_for_file: prefer_immutable_bloc_state, prefer_sealed_bloc_events, prefer_sealed_bloc_state, handle_bloc_event_subclasses, avoid_cubits, avoid_bloc_public_fields, avoid_bloc_public_methods, prefer_bloc_event_suffix, prefer_bloc_state_suffix, avoid_returning_value_from_cubit_methods, avoid_passing_build_context_to_blocs, unused_element, unused_field, unused_local_variable, prefer_widget_private_members, newline_before_method, newline_before_constructor, avoid_duplicate_bloc_event_handlers, avoid_empty_build_when, avoid_existing_instances_in_bloc_provider, avoid_instantiating_in_bloc_value_provider, avoid_passing_bloc_to_bloc, check_is_not_closed_after_async_gap, emit_new_bloc_state_instances, prefer_bloc_extensions, prefer_correct_bloc_provider, prefer_multi_bloc_provider, no_empty_string, avoid_async_call_in_sync_function, avoid_default_tostring, no_empty_block, arguments_ordering, dispose_providers, avoid_unnecessary_stateful_widgets, prefer_multi_provider, avoid_duplicate_collection_elements

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
