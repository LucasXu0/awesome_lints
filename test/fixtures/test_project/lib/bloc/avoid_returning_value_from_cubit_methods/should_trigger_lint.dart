import 'package:bloc/bloc.dart';

// Cubit methods returning values - should trigger lint
class UserCubit extends Cubit<String> {
  UserCubit() : super('');

  // expect_lint: avoid_returning_value_from_cubit_methods
  String getUser() {
    return state;
  }

  // expect_lint: avoid_returning_value_from_cubit_methods
  Future<String> fetchUser() async {
    return state;
  }

  // expect_lint: avoid_returning_value_from_cubit_methods
  int getUserCount() {
    return 0;
  }
}

// Multiple methods returning values
class DataCubit extends Cubit<Map<String, dynamic>> {
  DataCubit() : super({});

  // expect_lint: avoid_returning_value_from_cubit_methods
  bool isValid() {
    return true;
  }

  // expect_lint: avoid_returning_value_from_cubit_methods
  List<String> getItems() {
    return [];
  }

  // expect_lint: avoid_returning_value_from_cubit_methods
  Future<bool> validate() async {
    return false;
  }
}
