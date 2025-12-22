import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
}

// BlocBuilder without buildWhen - should trigger lint
class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return
    // expect_lint: avoid_empty_build_when
    BlocBuilder<CounterCubit, int>(
      builder: (context, state) {
        return Text('$state');
      },
    );
  }
}

// BlocConsumer without buildWhen - should trigger lint
class CounterConsumerWidget extends StatelessWidget {
  const CounterConsumerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return
    // expect_lint: avoid_empty_build_when
    BlocConsumer<CounterCubit, int>(
      listener: (context, state) {},
      builder: (context, state) {
        return Text('$state');
      },
    );
  }
}
