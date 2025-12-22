import 'package:bloc/bloc.dart';

sealed class CounterEvent {}

final class IncrementEvent extends CounterEvent {}

// State type ending with 'State' - should not trigger lint
sealed class CounterState {}

final class CounterInitial extends CounterState {}

final class CounterLoaded extends CounterState {}

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial()) {
    on<IncrementEvent>(_onIncrement);
  }

  void _onIncrement(IncrementEvent event, Emitter<CounterState> emit) {}
}

// Another example with correct suffix
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoaded extends UserState {}

class UserBloc extends Bloc<CounterEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<IncrementEvent>(_onIncrement);
  }

  void _onIncrement(IncrementEvent event, Emitter<UserState> emit) {}
}

// Cubit with correct state suffix
sealed class ThemeState {}

final class LightThemeState extends ThemeState {}

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(LightThemeState());
}

// Using primitives is fine - built-in types are exempted
class SimpleCubit extends Cubit<int> {
  SimpleCubit() : super(0);
}

// String primitives are also fine
class StringCubit extends Cubit<String> {
  StringCubit() : super('');
}
