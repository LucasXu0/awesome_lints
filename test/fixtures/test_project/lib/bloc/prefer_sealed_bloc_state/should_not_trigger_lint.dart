import 'package:flutter/widgets.dart';

// State with sealed modifier - should not trigger lint
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

// State with final modifier
final class SingleState {
  const SingleState();
}

// State with abstract modifier
abstract class BaseState {
  const BaseState();
}

final class ConcreteState extends BaseState {
  const ConcreteState();
}

// Sealed state hierarchy
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

final class UserError extends UserState {
  final String message;
  const UserError(this.message);
}

// Final concrete states
final class AuthInitialState {
  const AuthInitialState();
}

final class AuthLoadingState {
  const AuthLoadingState();
}

final class AuthSuccessState {
  final String token;
  const AuthSuccessState(this.token);
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

sealed class NotAState {}
