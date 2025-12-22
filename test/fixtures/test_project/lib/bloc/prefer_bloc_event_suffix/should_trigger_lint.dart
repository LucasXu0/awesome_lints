import 'package:bloc/bloc.dart';

// Event type not ending with 'Event' - should trigger lint
sealed class CounterAction {}

final class IncrementAction extends CounterAction {}

sealed class CounterState {}

final class CounterInitial extends CounterState {}

// expect_lint: prefer_bloc_event_suffix
class CounterBloc extends Bloc<CounterAction, CounterState> {
  CounterBloc() : super(CounterInitial()) {
    on<IncrementAction>(_onIncrement);
  }

  void _onIncrement(IncrementAction event, Emitter<CounterState> emit) {}
}

// Another example with wrong suffix
sealed class UserCommand {}

final class LoadUserCommand extends UserCommand {}

// expect_lint: prefer_bloc_event_suffix
class UserBloc extends Bloc<UserCommand, CounterState> {
  UserBloc() : super(CounterInitial()) {
    on<LoadUserCommand>(_onLoad);
  }

  void _onLoad(LoadUserCommand event, Emitter<CounterState> emit) {}
}
