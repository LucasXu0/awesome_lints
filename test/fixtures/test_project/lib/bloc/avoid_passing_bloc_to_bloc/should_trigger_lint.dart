// ignore_for_file: arguments_ordering, avoid_async_call_in_sync_function, avoid_bloc_public_fields, avoid_bloc_public_methods, avoid_cubits, avoid_default_tostring, avoid_duplicate_bloc_event_handlers, avoid_duplicate_collection_elements, avoid_empty_build_when, avoid_existing_instances_in_bloc_provider, avoid_instantiating_in_bloc_value_provider, avoid_passing_build_context_to_blocs, avoid_returning_value_from_cubit_methods, avoid_unnecessary_stateful_widgets, check_is_not_closed_after_async_gap, dispose_providers, emit_new_bloc_state_instances, handle_bloc_event_subclasses, newline_before_constructor, newline_before_method, no_empty_block, no_empty_string, prefer_async_await, prefer_bloc_event_suffix, prefer_bloc_extensions, prefer_bloc_state_suffix, prefer_contains, prefer_correct_bloc_provider, prefer_correct_for_loop_increment, prefer_early_return, prefer_immutable_bloc_events, prefer_immutable_bloc_state, prefer_iterable_of, prefer_multi_bloc_provider, prefer_multi_provider, prefer_named_boolean_parameters, prefer_sealed_bloc_events, prefer_sealed_bloc_state, prefer_switch_expression, prefer_widget_private_members, unused_element, unused_field, unused_local_variable

import 'package:bloc/bloc.dart';

class UserBloc extends Cubit<String> {
  UserBloc() : super('');
}

class AuthBloc extends Cubit<bool> {
  AuthBloc() : super(false);
}

// Passing Bloc to Bloc constructor - should trigger lint
class DashboardBloc extends Cubit<String> {
  // expect_lint: avoid_passing_bloc_to_bloc
  final UserBloc userBloc;

  DashboardBloc(this.userBloc) : super('');
}

// Passing multiple Blocs
class AppBloc extends Cubit<String> {
  // expect_lint: avoid_passing_bloc_to_bloc
  final UserBloc userBloc;
  // expect_lint: avoid_passing_bloc_to_bloc
  final AuthBloc authBloc;

  AppBloc(this.userBloc, this.authBloc) : super('');
}

// Passing Cubit to Cubit
class ThemeCubit extends Cubit<String> {
  ThemeCubit() : super('light');
}

class SettingsCubit extends Cubit<Map<String, dynamic>> {
  // expect_lint: avoid_passing_bloc_to_bloc
  final ThemeCubit themeCubit;

  SettingsCubit(this.themeCubit) : super({});
}
