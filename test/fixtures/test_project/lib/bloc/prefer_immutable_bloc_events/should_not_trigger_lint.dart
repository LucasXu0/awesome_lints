import 'package:flutter/foundation.dart';

// Event with @immutable annotation - should not trigger lint
@immutable
sealed class CounterEvent {
  const CounterEvent();
}

@immutable
final class IncrementEvent extends CounterEvent {
  const IncrementEvent();
}

@immutable
final class DecrementEvent extends CounterEvent {
  const DecrementEvent();
}

// Another event with @immutable
@immutable
sealed class UserEvent {
  const UserEvent();
}

@immutable
final class LoadUserEvent extends UserEvent {
  final String userId;
  const LoadUserEvent(this.userId);
}

// Events with @immutable
@immutable
sealed class AuthEvent {
  const AuthEvent();
}

@immutable
final class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  const LoginEvent(this.username, this.password);
}

@immutable
final class LogoutEvent extends AuthEvent {
  const LogoutEvent();
}

// Classes not ending with Event are ignored
class RegularClass {}
