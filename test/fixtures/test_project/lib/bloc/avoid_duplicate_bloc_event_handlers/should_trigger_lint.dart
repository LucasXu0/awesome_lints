import 'package:bloc/bloc.dart';

sealed class CounterEvent {}

final class IncrementEvent extends CounterEvent {}

final class DecrementEvent extends CounterEvent {}

sealed class CounterState {}

final class CounterInitial extends CounterState {}

// Duplicate event handlers - should trigger lint
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial()) {
    on<IncrementEvent>(_onIncrement);
    // expect_lint: avoid_duplicate_bloc_event_handlers
    on<IncrementEvent>(_onIncrementAgain);
  }

  void _onIncrement(IncrementEvent event, Emitter<CounterState> emit) {
    // First handler
  }

  void _onIncrementAgain(IncrementEvent event, Emitter<CounterState> emit) {
    // Duplicate handler
  }
}

// Multiple duplicate handlers
class UserBloc extends Bloc<CounterEvent, CounterState> {
  UserBloc() : super(CounterInitial()) {
    on<IncrementEvent>(_handler1);
    // expect_lint: avoid_duplicate_bloc_event_handlers
    on<IncrementEvent>(_handler2);
    // expect_lint: avoid_duplicate_bloc_event_handlers
    on<IncrementEvent>(_handler3);
  }

  void _handler1(IncrementEvent event, Emitter<CounterState> emit) {}
  void _handler2(IncrementEvent event, Emitter<CounterState> emit) {}
  void _handler3(IncrementEvent event, Emitter<CounterState> emit) {}
}
