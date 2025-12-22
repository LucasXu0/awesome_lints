import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
}

// Using context.read - should not trigger lint
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final cubit = context.read<CounterCubit>();
        cubit.state;
      },
      child: Container(),
    );
  }
}

// Using context.watch - should not trigger lint
class WatchWidget extends StatelessWidget {
  const WatchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final count = context.watch<CounterCubit>().state;

    return Text('$count');
  }
}

// Using context.select - should not trigger lint
class SelectWidget extends StatelessWidget {
  const SelectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final count = context.select((CounterCubit cubit) => cubit.state);

    return Text('$count');
  }
}
