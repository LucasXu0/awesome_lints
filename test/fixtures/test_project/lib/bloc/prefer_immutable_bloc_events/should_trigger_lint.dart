// Event without @immutable annotation - should trigger lint

// expect_lint: prefer_immutable_bloc_events
sealed class CounterEvent {}

// expect_lint: prefer_immutable_bloc_events
final class IncrementEvent extends CounterEvent {}

// expect_lint: prefer_immutable_bloc_events
final class DecrementEvent extends CounterEvent {}

// Another event without @immutable
// expect_lint: prefer_immutable_bloc_events
sealed class UserEvent {}

// expect_lint: prefer_immutable_bloc_events
final class LoadUserEvent extends UserEvent {
  final String userId;
  LoadUserEvent(this.userId);
}

// Multiple events without @immutable
// expect_lint: prefer_immutable_bloc_events
sealed class AuthEvent {}

// expect_lint: prefer_immutable_bloc_events
final class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  LoginEvent(this.username, this.password);
}

// expect_lint: prefer_immutable_bloc_events
final class LogoutEvent extends AuthEvent {}
