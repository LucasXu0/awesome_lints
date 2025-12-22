import 'package:bloc/bloc.dart';

class UserBloc extends Cubit<String> {
  UserBloc() : super('');
}

class AuthBloc extends Cubit<bool> {
  AuthBloc() : super(false);
}

// Passing Bloc to Bloc constructor - should trigger lint
class DashboardBloc extends Cubit<String> {
  // expect_lint: avoid_passing_bloc_to_bloc
  final UserBloc userBloc;

  DashboardBloc(this.userBloc) : super('');
}

// Passing multiple Blocs
class AppBloc extends Cubit<String> {
  // expect_lint: avoid_passing_bloc_to_bloc
  final UserBloc userBloc;
  // expect_lint: avoid_passing_bloc_to_bloc
  final AuthBloc authBloc;

  AppBloc(this.userBloc, this.authBloc) : super('');
}

// Passing Cubit to Cubit
class ThemeCubit extends Cubit<String> {
  ThemeCubit() : super('light');
}

class SettingsCubit extends Cubit<Map<String, dynamic>> {
  // expect_lint: avoid_passing_bloc_to_bloc
  final ThemeCubit themeCubit;

  SettingsCubit(this.themeCubit) : super({});
}
