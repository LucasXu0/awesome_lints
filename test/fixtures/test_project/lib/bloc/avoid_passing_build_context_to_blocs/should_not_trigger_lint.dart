import 'package:bloc/bloc.dart';

// Cubit methods without BuildContext - should not trigger lint
class NavigationCubit extends Cubit<String> {
  NavigationCubit() : super('home');

  void navigateTo(String route) {
    emit(route);
  }

  void goBack() {
    emit('previous');
  }
}

// Event without BuildContext
sealed class AuthEvent {}

final class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  LoginEvent(this.username, this.password);
}

final class LogoutEvent extends AuthEvent {
  LogoutEvent();
}

// Regular Bloc with proper events
sealed class UserState {}

final class UserInitial extends UserState {}

class UserBloc extends Bloc<AuthEvent, UserState> {
  UserBloc() : super(UserInitial());
}

// Cubit with no parameters
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}
