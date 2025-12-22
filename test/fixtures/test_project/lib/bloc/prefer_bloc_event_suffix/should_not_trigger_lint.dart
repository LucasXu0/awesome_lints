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
