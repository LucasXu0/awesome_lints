import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
}

// Creating new instance in BlocProvider.value - should trigger lint
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>.value(
      // expect_lint: avoid_instantiating_in_bloc_value_provider
      value: CounterCubit(),
      child: Container(),
    );
  }
}

// Another example with different bloc
class ThemeBloc extends Cubit<String> {
  ThemeBloc() : super('light');
}

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>.value(
      // expect_lint: avoid_instantiating_in_bloc_value_provider
      value: ThemeBloc(),
      child: Container(),
    );
  }
}
