// ignore_for_file: arguments_ordering, avoid_async_call_in_sync_function, avoid_bloc_public_fields, avoid_bloc_public_methods, avoid_cubits, avoid_default_tostring, avoid_duplicate_bloc_event_handlers, avoid_duplicate_collection_elements, avoid_empty_build_when, avoid_existing_instances_in_bloc_provider, avoid_instantiating_in_bloc_value_provider, avoid_passing_bloc_to_bloc, avoid_passing_build_context_to_blocs, avoid_returning_value_from_cubit_methods, avoid_unnecessary_stateful_widgets, dispose_providers, emit_new_bloc_state_instances, handle_bloc_event_subclasses, newline_before_constructor, newline_before_method, no_empty_block, no_empty_string, prefer_async_await, prefer_bloc_event_suffix, prefer_bloc_extensions, prefer_bloc_state_suffix, prefer_contains, prefer_correct_bloc_provider, prefer_correct_for_loop_increment, prefer_early_return, prefer_immutable_bloc_events, prefer_immutable_bloc_state, prefer_iterable_of, prefer_multi_bloc_provider, prefer_multi_provider, prefer_named_boolean_parameters, prefer_sealed_bloc_events, prefer_sealed_bloc_state, prefer_switch_expression, prefer_widget_private_members, unused_element, unused_field, unused_local_variable

import 'package:bloc/bloc.dart';

sealed class DataEvent {}

final class FetchDataEvent extends DataEvent {}

sealed class DataState {}

final class DataInitial extends DataState {}

// Adding event after async gap without isClosed check - should trigger lint
class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(DataInitial()) {
    on<FetchDataEvent>((event, emit) async {
      await Future.delayed(const Duration(seconds: 1));
      // expect_lint: check_is_not_closed_after_async_gap
      add(FetchDataEvent());
    });
  }
}

// Multiple async gaps without checks
class UserBloc extends Bloc<DataEvent, DataState> {
  UserBloc() : super(DataInitial()) {
    on<FetchDataEvent>((event, emit) async {
      await Future.delayed(const Duration(seconds: 1));
      // expect_lint: check_is_not_closed_after_async_gap
      add(FetchDataEvent());

      await Future.delayed(const Duration(seconds: 1));
      // expect_lint: check_is_not_closed_after_async_gap
      add(FetchDataEvent());
    });
  }
}
