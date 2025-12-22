import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
}

// Using BlocProvider.of - should trigger lint
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // expect_lint: prefer_bloc_extensions
    final cubit = BlocProvider.of<CounterCubit>(context);

    return Text('${cubit.state}');
  }
}

// Another example with BlocProvider.of
class AnotherWidget extends StatelessWidget {
  const AnotherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // expect_lint: prefer_bloc_extensions
        BlocProvider.of<CounterCubit>(context).state;
      },
      child: Container(),
    );
  }
}
