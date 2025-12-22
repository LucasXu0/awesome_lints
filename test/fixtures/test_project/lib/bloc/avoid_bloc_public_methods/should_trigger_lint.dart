import 'package:bloc/bloc.dart';

sealed class CounterEvent {}

final class IncrementEvent extends CounterEvent {}

sealed class CounterState {}

final class CounterInitial extends CounterState {}

// Public method in Bloc - should trigger lint
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial());

  // expect_lint: avoid_bloc_public_methods
  void incrementCounter() {
    // Should use events instead
  }

  // expect_lint: avoid_bloc_public_methods
  Future<void> loadData() async {
    // Should use events instead
  }
}

// Multiple public methods
class UserBloc extends Bloc<CounterEvent, CounterState> {
  UserBloc() : super(CounterInitial());

  // expect_lint: avoid_bloc_public_methods
  void updateUser(String name) {
    // Should use events
  }

  // expect_lint: avoid_bloc_public_methods
  void deleteUser() {
    // Should use events
  }
}
