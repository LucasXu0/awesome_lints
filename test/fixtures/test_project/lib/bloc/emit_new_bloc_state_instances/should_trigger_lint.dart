import 'package:bloc/bloc.dart';

sealed class CounterState {
  const CounterState();
}

final class CounterInitial extends CounterState {
  const CounterInitial();
}

final class CounterValue extends CounterState {
  final int value;
  const CounterValue(this.value);
}

// Emitting existing state instance - should trigger lint
class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(const CounterInitial());

  void doSomething() {
    // expect_lint: emit_new_bloc_state_instances
    emit(state);
  }

  void anotherMethod() {
    // expect_lint: emit_new_bloc_state_instances
    emit(state);
  }
}

// Another example
class DataCubit extends Cubit<CounterState> {
  DataCubit() : super(const CounterInitial());

  void update() {
    // expect_lint: emit_new_bloc_state_instances
    emit(state);
  }
}
