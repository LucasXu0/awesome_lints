import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
}

// Creating new instance in BlocProvider.create - should not trigger lint
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

// Creating new instance with parameters
class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (context) {
        return CounterCubit();
      },
      child: Container(),
    );
  }
}

// Using BlocProvider.value with existing instance is correct
class MyApp3 extends StatelessWidget {
  const MyApp3({super.key});

  @override
  Widget build(BuildContext context) {
    final existingCubit = CounterCubit();

    return BlocProvider<CounterCubit>.value(
      value: existingCubit,
      child: Container(),
    );
  }
}
