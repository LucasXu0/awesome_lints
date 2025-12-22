import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
}

// BlocBuilder with buildWhen - should not trigger lint
class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterCubit, int>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return Text('$state');
      },
    );
  }
}

// BlocConsumer with buildWhen - should not trigger lint
class CounterConsumerWidget extends StatelessWidget {
  const CounterConsumerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CounterCubit, int>(
      buildWhen: (previous, current) => current % 2 == 0,
      listener: (context, state) {},
      builder: (context, state) {
        return Text('$state');
      },
    );
  }
}

// BlocListener doesn't need buildWhen
class CounterListenerWidget extends StatelessWidget {
  const CounterListenerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CounterCubit, int>(
      listener: (context, state) {},
      child: const Text('Counter'),
    );
  }
}
