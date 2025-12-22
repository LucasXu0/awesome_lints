// Event without sealed/final modifier - should trigger lint

// expect_lint: prefer_sealed_bloc_events
class CounterEvent {
  const CounterEvent();
}

final class IncrementEvent extends CounterEvent {
  const IncrementEvent();
}

final class DecrementEvent extends CounterEvent {
  const DecrementEvent();
}

// Another event without modifier
// expect_lint: prefer_sealed_bloc_events
class UserEvent {
  const UserEvent();
}

final class LoadUserEvent extends UserEvent {
  final String userId;
  const LoadUserEvent(this.userId);
}

// Base event without sealed
// expect_lint: prefer_sealed_bloc_events
class AuthEvent {
  const AuthEvent();
}

final class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  const LoginEvent(this.username, this.password);
}

final class LogoutEvent extends AuthEvent {
  const LogoutEvent();
}
