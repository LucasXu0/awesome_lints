// State without @immutable annotation - should trigger lint

// expect_lint: prefer_immutable_bloc_state
sealed class CounterState {}

final class CounterInitial extends CounterState {}

final class CounterValue extends CounterState {
  final int value;
  CounterValue(this.value);
}

// Another state without @immutable
// expect_lint: prefer_immutable_bloc_state
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoaded extends UserState {
  final String name;
  UserLoaded(this.name);
}

// Multiple states without @immutable
// expect_lint: prefer_immutable_bloc_state
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final String token;
  AuthSuccess(this.token);
}
