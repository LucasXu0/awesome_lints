// Event with sealed modifier - should not trigger lint
sealed class CounterEvent {
  const CounterEvent();
}

final class IncrementEvent extends CounterEvent {
  const IncrementEvent();
}

final class DecrementEvent extends CounterEvent {
  const DecrementEvent();
}

// Event with final modifier
final class SingleEvent {
  const SingleEvent();
}

// Event with abstract modifier
abstract class BaseEvent {
  const BaseEvent();
}

final class ConcreteEvent extends BaseEvent {
  const ConcreteEvent();
}

// Sealed event hierarchy
sealed class UserEvent {
  const UserEvent();
}

final class LoadUserEvent extends UserEvent {
  final String userId;
  const LoadUserEvent(this.userId);
}

final class UpdateUserEvent extends UserEvent {
  final String name;
  const UpdateUserEvent(this.name);
}

// Final concrete events
final class AuthLoginEvent {
  final String username;
  final String password;

  const AuthLoginEvent(this.username, this.password);
}

final class AuthLogoutEvent {
  const AuthLogoutEvent();
}

// Classes not ending with Event are ignored
class RegularClass {}

sealed class NotAnEvent {}
