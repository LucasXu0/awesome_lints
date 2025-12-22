import 'package:bloc/bloc.dart';

sealed class CounterState {
  const CounterState();

  CounterState copyWith();
}

final class CounterInitial extends CounterState {
  const CounterInitial();

  @override
  CounterState copyWith() => const CounterInitial();
}

final class CounterValue extends CounterState {
  final int value;
  const CounterValue(this.value);

  @override
  CounterState copyWith() => CounterValue(value);
}

// Emitting new state instances - should not trigger lint
class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(const CounterInitial());

  void incrementWithCopyWith() {
    emit(state.copyWith());
  }

  void incrementWithNew() {
    emit(const CounterValue(1));
  }

  void reset() {
    emit(const CounterInitial());
  }
}

// Using state in conditions but not emitting it
class DataCubit extends Cubit<CounterState> {
  DataCubit() : super(const CounterInitial());

  void update() {
    if (state is CounterInitial) {
      emit(const CounterValue(0));
    }
  }
}
