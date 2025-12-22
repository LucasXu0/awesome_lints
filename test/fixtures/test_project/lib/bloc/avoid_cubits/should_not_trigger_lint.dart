import 'package:bloc/bloc.dart';

sealed class CounterEvent {}

final class IncrementEvent extends CounterEvent {}

final class DecrementEvent extends CounterEvent {}

sealed class CounterState {}

final class CounterInitial extends CounterState {}

// Using Bloc instead of Cubit - should not trigger lint
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

// Regular class - should not trigger lint
class RegularClass {
  void doSomething() {}
}
