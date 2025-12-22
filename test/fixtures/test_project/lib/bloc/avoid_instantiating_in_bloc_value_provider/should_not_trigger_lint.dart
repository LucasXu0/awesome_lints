import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
}

// Using existing instance in BlocProvider.value - should not trigger lint
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final existingCubit = CounterCubit();

    return BlocProvider<CounterCubit>.value(
      value: existingCubit,
      child: Container(),
    );
  }
}

// Using value from context
class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>.value(
      value: context.read<CounterCubit>(),
      child: Container(),
    );
  }
}

// Using BlocProvider (not .value) with new instance is correct
class MyApp3 extends StatelessWidget {
  const MyApp3({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (_) => CounterCubit(),
      child: Container(),
    );
  }
}
