import 'package:bloc/bloc.dart';

sealed class CounterEvent {}

final class IncrementEvent extends CounterEvent {}

final class DecrementEvent extends CounterEvent {}

sealed class CounterState {}

final class CounterInitial extends CounterState {}

// Bloc with no event handlers - should trigger lint
// expect_lint: handle_bloc_event_subclasses
class EmptyBloc extends Bloc<CounterEvent, CounterState> {
  EmptyBloc() : super(CounterInitial());
}
