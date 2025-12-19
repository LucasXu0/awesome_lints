// ignore_for_file: unused_element, prefer_immutable_bloc_events, prefer_immutable_bloc_state, prefer_sealed_bloc_events, prefer_sealed_bloc_state, handle_bloc_event_subclasses, avoid_cubits, avoid_bloc_public_fields, avoid_bloc_public_methods, prefer_bloc_state_suffix, avoid_returning_value_from_cubit_methods, avoid_passing_build_context_to_blocs, unused_field, unused_local_variable, prefer_widget_private_members, newline_before_method, newline_before_constructor, avoid_duplicate_bloc_event_handlers, avoid_empty_build_when, avoid_existing_instances_in_bloc_provider, avoid_instantiating_in_bloc_value_provider, avoid_passing_bloc_to_bloc, check_is_not_closed_after_async_gap, emit_new_bloc_state_instances, prefer_bloc_extensions, prefer_correct_bloc_provider, prefer_multi_bloc_provider, no_empty_string, avoid_async_call_in_sync_function, avoid_default_tostring, no_empty_block, arguments_ordering, dispose_providers, avoid_unnecessary_stateful_widgets, prefer_multi_provider, avoid_duplicate_collection_elements

import 'package:bloc/bloc.dart';

// Event type ending with 'Event' - should not trigger lint
sealed class CounterEvent {}

final class IncrementEvent extends CounterEvent {}

final class DecrementEvent extends CounterEvent {}

sealed class CounterState {}

final class CounterInitial extends CounterState {}

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial()) {
    on<IncrementEvent>(_onIncrement);
    on<DecrementEvent>(_onDecrement);
  }

  void _onIncrement(IncrementEvent event, Emitter<CounterState> emit) {}
  void _onDecrement(DecrementEvent event, Emitter<CounterState> emit) {}
}

// Another example with correct suffix
sealed class UserEvent {}

final class LoadUserEvent extends UserEvent {}

class UserBloc extends Bloc<UserEvent, CounterState> {
  UserBloc() : super(CounterInitial()) {
    on<LoadUserEvent>(_onLoad);
  }

  void _onLoad(LoadUserEvent event, Emitter<CounterState> emit) {}
}

// Cubit doesn't need Event suffix
class SimpleCubit extends Cubit<int> {
  SimpleCubit() : super(0);
}
