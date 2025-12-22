import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
}

class UserRepository {
  String getUser() => '';
}

// Using BlocProvider for Bloc - should not trigger lint
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (_) => CounterCubit(),
      child: Container(),
    );
  }
}

// Using Provider for non-Bloc classes - should not trigger lint
class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<UserRepository>(
      create: (_) => UserRepository(),
      child: Container(),
    );
  }
}

// Using Provider for primitives
class MyApp3 extends StatelessWidget {
  const MyApp3({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<String>(create: (_) => 'value', child: Container());
  }
}
