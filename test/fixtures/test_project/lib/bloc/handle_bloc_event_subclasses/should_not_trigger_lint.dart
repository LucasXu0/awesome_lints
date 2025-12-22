import 'package:bloc/bloc.dart';

sealed class CounterEvent {}

final class IncrementEvent extends CounterEvent {}

final class DecrementEvent extends CounterEvent {}

sealed class CounterState {}

final class CounterInitial extends CounterState {}

// Bloc with event handlers - should not trigger lint
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial()) {
    on<IncrementEvent>(_onIncrement);
    on<DecrementEvent>(_onDecrement);
  }

  void _onIncrement(IncrementEvent event, Emitter<CounterState> emit) {
    // Handle increment
  }

  void _onDecrement(DecrementEvent event, Emitter<CounterState> emit) {
    // Handle decrement
  }
}

// Bloc handling parent event class
class ParentHandlerBloc extends Bloc<CounterEvent, CounterState> {
  ParentHandlerBloc() : super(CounterInitial()) {
    on<CounterEvent>(_onEvent);
  }

  void _onEvent(CounterEvent event, Emitter<CounterState> emit) {
    // Handle all events
  }
}

// Bloc with at least one handler
class PartialBloc extends Bloc<CounterEvent, CounterState> {
  PartialBloc() : super(CounterInitial()) {
    on<IncrementEvent>(_onIncrement);
  }

  void _onIncrement(IncrementEvent event, Emitter<CounterState> emit) {
    // Handle increment
  }
}
