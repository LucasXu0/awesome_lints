import 'package:bloc/bloc.dart';

sealed class CounterEvent {}

final class IncrementEvent extends CounterEvent {}

sealed class CounterState {}

final class CounterInitial extends CounterState {}

// Private field in Bloc - should not trigger lint
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  final int _privateCounter = 0;

  CounterBloc() : super(CounterInitial());
}

// Private field in Cubit - should not trigger lint
class ThemeCubit extends Cubit<String> {
  final String _currentTheme = 'light';

  ThemeCubit() : super('light');
}

// No fields at all
class SimpleBloc extends Bloc<CounterEvent, CounterState> {
  SimpleBloc() : super(CounterInitial());
}

// Regular class with public field - should not trigger lint
class RegularClass {
  String publicField = '';
}
