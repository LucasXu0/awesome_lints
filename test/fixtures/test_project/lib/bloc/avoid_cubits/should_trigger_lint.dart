import 'package:bloc/bloc.dart';

// expect_lint: avoid_cubits
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}

// expect_lint: avoid_cubits
class ThemeCubit extends Cubit<String> {
  ThemeCubit() : super('light');

  void toggleTheme() {
    emit(state == 'light' ? 'dark' : 'light');
  }
}

// expect_lint: avoid_cubits
class UserCubit extends Cubit<Map<String, dynamic>> {
  UserCubit() : super({});

  void updateUser(String name) {
    emit({'name': name});
  }
}
