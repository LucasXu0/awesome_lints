import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:bloc/bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
}

class UserBloc extends Cubit<String> {
  UserBloc() : super('');
}

// Using Provider for Bloc - should trigger lint
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
    // expect_lint: prefer_correct_bloc_provider
    Provider<CounterCubit>(create: (_) => CounterCubit(), child: Container());
  }
}

// Using Provider for Cubit
class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return
    // expect_lint: prefer_correct_bloc_provider
    Provider<UserBloc>(create: (_) => UserBloc(), child: Container());
  }
}
