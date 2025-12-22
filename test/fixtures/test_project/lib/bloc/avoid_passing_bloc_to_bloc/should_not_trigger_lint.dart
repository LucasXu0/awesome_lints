import 'package:bloc/bloc.dart';

// Repository pattern - should not trigger lint
class UserRepository {
  Future<String> getUser() async => 'user';
}

class UserBloc extends Cubit<String> {
  final UserRepository repository;

  UserBloc(this.repository) : super('');

  Future<void> loadUser() async {
    final user = await repository.getUser();
    emit(user);
  }
}

// Using dependency injection with regular classes
class AuthService {
  bool isAuthenticated() => false;
}

class AuthBloc extends Cubit<bool> {
  final AuthService authService;

  AuthBloc(this.authService) : super(false);
}

// No dependencies
class SimpleBloc extends Cubit<int> {
  SimpleBloc() : super(0);
}

// Using primitive types
class CounterBloc extends Cubit<int> {
  final int initialValue;

  CounterBloc(this.initialValue) : super(initialValue);
}
