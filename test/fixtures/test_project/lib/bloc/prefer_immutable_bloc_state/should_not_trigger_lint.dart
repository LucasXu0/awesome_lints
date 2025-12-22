import 'package:flutter/widgets.dart';

// State with @immutable annotation - should not trigger lint
@immutable
sealed class CounterState {
  const CounterState();
}

final class CounterInitial extends CounterState {
  const CounterInitial();
}

final class CounterValue extends CounterState {
  final int value;
  const CounterValue(this.value);
}

// Another state with @immutable
@immutable
sealed class UserState {
  const UserState();
}

final class UserInitial extends UserState {
  const UserInitial();
}

final class UserLoaded extends UserState {
  final String name;
  const UserLoaded(this.name);
}

// States with @immutable
@immutable
sealed class AuthState {
  const AuthState();
}

@immutable
final class AuthInitial extends AuthState {
  const AuthInitial();
}

@immutable
final class AuthLoading extends AuthState {
  const AuthLoading();
}

@immutable
final class AuthSuccess extends AuthState {
  final String token;
  const AuthSuccess(this.token);
}

// Flutter State class should be ignored
class MyWidgetState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Classes not ending with State are ignored
class RegularClass {}
