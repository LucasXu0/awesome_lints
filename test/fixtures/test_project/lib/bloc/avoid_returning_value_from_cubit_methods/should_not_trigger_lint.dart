import 'package:bloc/bloc.dart';

// Cubit methods with void return type - should not trigger lint
class UserCubit extends Cubit<String> {
  UserCubit() : super('');

  void updateUser(String name) {
    emit(name);
  }

  Future<void> fetchUser() async {
    emit('user');
  }

  void deleteUser() {
    emit('');
  }
}

// Getters are allowed
class DataCubit extends Cubit<int> {
  DataCubit() : super(0);

  int get currentValue => state;

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}

// Private methods with return values are allowed
class SettingsCubit extends Cubit<Map<String, dynamic>> {
  SettingsCubit() : super({});

  bool _isValid() {
    return true;
  }

  String _getValue() {
    return '';
  }

  void updateSettings() {
    if (_isValid()) {
      emit({'value': _getValue()});
    }
  }
}

// Override methods are allowed
class CustomCubit extends Cubit<String> {
  CustomCubit() : super('');

  @override
  Future<void> close() {
    return super.close();
  }
}
