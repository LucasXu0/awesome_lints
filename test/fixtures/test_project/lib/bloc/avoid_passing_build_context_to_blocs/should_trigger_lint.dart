import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

// Cubit method with BuildContext parameter - should trigger lint
class NavigationCubit extends Cubit<String> {
  NavigationCubit() : super('home');

  // expect_lint: avoid_passing_build_context_to_blocs
  void navigateTo(BuildContext context, String route) {
    // Bad: using context in Cubit
    emit(route);
  }
}

// Event with BuildContext field - should trigger lint
sealed class AuthEvent {}

final class LoginEvent extends AuthEvent {
  // expect_lint: avoid_passing_build_context_to_blocs
  final BuildContext context;

  LoginEvent(this.context);
}

// Event with BuildContext constructor parameter - should trigger lint
final class LogoutEvent extends AuthEvent {
  // expect_lint: avoid_passing_build_context_to_blocs
  LogoutEvent(BuildContext context);
}

// Multiple BuildContext parameters
class DialogCubit extends Cubit<bool> {
  DialogCubit() : super(false);

  // expect_lint: avoid_passing_build_context_to_blocs
  void showDialog(BuildContext context, String message) {
    // Bad: using context
  }
}
