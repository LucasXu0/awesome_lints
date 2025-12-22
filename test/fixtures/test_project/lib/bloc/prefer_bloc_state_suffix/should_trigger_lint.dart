import 'package:bloc/bloc.dart';

sealed class CounterEvent {}

final class IncrementEvent extends CounterEvent {}

// State type not ending with 'State' - should trigger lint
sealed class CounterData {}

final class CounterInitialData extends CounterData {}

// expect_lint: prefer_bloc_state_suffix
class CounterBloc extends Bloc<CounterEvent, CounterData> {
  CounterBloc() : super(CounterInitialData()) {
    on<IncrementEvent>(_onIncrement);
  }

  void _onIncrement(IncrementEvent event, Emitter<CounterData> emit) {}
}

// Another example with wrong suffix
sealed class UserInfo {}

final class UserInfoLoaded extends UserInfo {}

// expect_lint: prefer_bloc_state_suffix
class UserBloc extends Bloc<CounterEvent, UserInfo> {
  UserBloc() : super(UserInfoLoaded()) {
    on<IncrementEvent>(_onIncrement);
  }

  void _onIncrement(IncrementEvent event, Emitter<UserInfo> emit) {}
}

// Cubit with wrong state suffix
sealed class ThemeValue {}

final class LightThemeValue extends ThemeValue {}

// expect_lint: prefer_bloc_state_suffix
class ThemeCubit extends Cubit<ThemeValue> {
  ThemeCubit() : super(LightThemeValue());
}
