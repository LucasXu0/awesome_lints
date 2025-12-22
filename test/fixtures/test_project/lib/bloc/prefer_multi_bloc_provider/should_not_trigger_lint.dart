import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
}

class ThemeCubit extends Cubit<String> {
  ThemeCubit() : super('light');
}

// Using MultiBlocProvider - should not trigger lint
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterCubit>(create: (_) => CounterCubit()),
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
      ],
      child: Container(),
    );
  }
}

// Single BlocProvider - should not trigger lint
class SingleProviderApp extends StatelessWidget {
  const SingleProviderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (_) => CounterCubit(),
      child: Container(),
    );
  }
}

// Using MultiBlocListener - should not trigger lint
class ListenerExample extends StatelessWidget {
  const ListenerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CounterCubit, int>(listener: (context, state) {}),
        BlocListener<ThemeCubit, String>(listener: (context, state) {}),
      ],
      child: Container(),
    );
  }
}

// Different widgets as children - should not trigger lint
class DifferentChildrenExample extends StatelessWidget {
  const DifferentChildrenExample({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (_) => CounterCubit(),
      child: Column(children: [Container(), Container()]),
    );
  }
}
