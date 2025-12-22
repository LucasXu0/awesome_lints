import 'package:bloc/bloc.dart';

sealed class CounterEvent {}

final class IncrementEvent extends CounterEvent {}

sealed class CounterState {}

final class CounterInitial extends CounterState {}

// Private methods in Bloc - should not trigger lint
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial());

  void _privateMethod() {
    // Private methods are fine
  }

  Future<void> _privateAsyncMethod() async {
    // Private async methods are fine
  }
}

// Override methods are allowed
class CustomBloc extends Bloc<CounterEvent, CounterState> {
  CustomBloc() : super(CounterInitial());

  @override
  Future<void> close() {
    // Overridden methods are allowed
    return super.close();
  }
}

// Getters and setters don't trigger the lint
class DataBloc extends Bloc<CounterEvent, CounterState> {
  DataBloc() : super(CounterInitial());

  String get currentValue => state.toString();

  set value(String newValue) {
    // Setters are allowed
  }
}

// Cubit can have public methods (lint only applies to Bloc)
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() {
    emit(state + 1);
  }
}
