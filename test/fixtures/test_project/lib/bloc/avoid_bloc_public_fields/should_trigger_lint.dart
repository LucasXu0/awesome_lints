import 'package:bloc/bloc.dart';

sealed class CounterEvent {}

final class IncrementEvent extends CounterEvent {}

sealed class CounterState {}

final class CounterInitial extends CounterState {}

// Public field in Bloc - should trigger lint
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  // expect_lint: avoid_bloc_public_fields
  int publicCounter = 0;

  CounterBloc() : super(CounterInitial());
}

// Public field in Cubit - should also trigger lint
class ThemeCubit extends Cubit<String> {
  // expect_lint: avoid_bloc_public_fields
  String currentTheme = 'light';

  ThemeCubit() : super('light');
}

// Multiple public fields
class UserBloc extends Bloc<CounterEvent, CounterState> {
  // expect_lint: avoid_bloc_public_fields
  String userName = '';
  // expect_lint: avoid_bloc_public_fields
  int userId = 0;

  UserBloc() : super(CounterInitial());
}
