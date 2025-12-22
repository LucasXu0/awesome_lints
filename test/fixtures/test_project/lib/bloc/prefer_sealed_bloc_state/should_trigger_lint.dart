// State without sealed/final modifier - should trigger lint

// expect_lint: prefer_sealed_bloc_state
class CounterState {
  const CounterState();
}

final class CounterInitial extends CounterState {
  const CounterInitial();
}

final class CounterValue extends CounterState {
  final int value;
  const CounterValue(this.value);
}

// Another state without modifier
// expect_lint: prefer_sealed_bloc_state
class UserState {
  const UserState();
}

final class UserInitial extends UserState {
  const UserInitial();
}

final class UserLoaded extends UserState {
  final String name;
  const UserLoaded(this.name);
}

// Base state without sealed
// expect_lint: prefer_sealed_bloc_state
class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class AuthLoading extends AuthState {
  const AuthLoading();
}

final class AuthSuccess extends AuthState {
  final String token;
  const AuthSuccess(this.token);
}
