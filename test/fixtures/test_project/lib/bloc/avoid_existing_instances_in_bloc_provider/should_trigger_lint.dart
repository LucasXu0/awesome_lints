import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
}

// Using existing instance in BlocProvider.create - should trigger lint
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final counterCubit = CounterCubit();

    return BlocProvider<CounterCubit>(
      // expect_lint: avoid_existing_instances_in_bloc_provider
      create: (_) => counterCubit,
      child: Container(),
    );
  }
}

// Using existing instance with return statement
class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    final myBloc = CounterCubit();

    return BlocProvider<CounterCubit>(
      create: (_) {
        // expect_lint: avoid_existing_instances_in_bloc_provider
        return myBloc;
      },
      child: Container(),
    );
  }
}
