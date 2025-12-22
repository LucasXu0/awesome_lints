import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
}

class ThemeCubit extends Cubit<String> {
  ThemeCubit() : super('light');
}

// Nested BlocProviders - should trigger lint
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
    // expect_lint: prefer_multi_bloc_provider
    BlocProvider<CounterCubit>(
      create: (_) => CounterCubit(),
      child: BlocProvider<ThemeCubit>(
        create: (_) => ThemeCubit(),
        child: Container(),
      ),
    );
  }
}

// Nested BlocListeners - should trigger lint
class ListenerExample extends StatelessWidget {
  const ListenerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return
    // expect_lint: prefer_multi_bloc_provider
    BlocListener<CounterCubit, int>(
      listener: (context, state) {},
      child: BlocListener<ThemeCubit, String>(
        listener: (context, state) {},
        child: Container(),
      ),
    );
  }
}
