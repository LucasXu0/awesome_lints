// ignore_for_file: prefer_immutable_bloc_events, prefer_immutable_bloc_state, prefer_sealed_bloc_events, prefer_sealed_bloc_state, handle_bloc_event_subclasses, avoid_cubits, avoid_bloc_public_fields, avoid_bloc_public_methods, prefer_bloc_event_suffix, prefer_bloc_state_suffix, avoid_returning_value_from_cubit_methods, avoid_passing_build_context_to_blocs, unused_element, unused_field, unused_local_variable, prefer_widget_private_members, newline_before_method, newline_before_constructor, avoid_duplicate_bloc_event_handlers, avoid_existing_instances_in_bloc_provider, avoid_instantiating_in_bloc_value_provider, avoid_passing_bloc_to_bloc, check_is_not_closed_after_async_gap, emit_new_bloc_state_instances, prefer_bloc_extensions, prefer_correct_bloc_provider, prefer_multi_bloc_provider, no_empty_string, avoid_async_call_in_sync_function, avoid_default_tostring, no_empty_block, arguments_ordering, dispose_providers, avoid_unnecessary_stateful_widgets, prefer_multi_provider, avoid_duplicate_collection_elements

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
