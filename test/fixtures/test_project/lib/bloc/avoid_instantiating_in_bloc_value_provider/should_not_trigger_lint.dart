// ignore_for_file: arguments_ordering, avoid_async_call_in_sync_function, avoid_bloc_public_fields, avoid_bloc_public_methods, avoid_cubits, avoid_default_tostring, avoid_duplicate_bloc_event_handlers, avoid_duplicate_collection_elements, avoid_empty_build_when, avoid_existing_instances_in_bloc_provider, avoid_passing_bloc_to_bloc, avoid_passing_build_context_to_blocs, avoid_read_inside_build, avoid_returning_value_from_cubit_methods, avoid_unnecessary_stateful_widgets, check_is_not_closed_after_async_gap, dispose_providers, emit_new_bloc_state_instances, handle_bloc_event_subclasses, newline_before_constructor, newline_before_method, no_empty_block, no_empty_string, prefer_async_await, prefer_bloc_event_suffix, prefer_bloc_extensions, prefer_bloc_state_suffix, prefer_contains, prefer_correct_bloc_provider, prefer_correct_for_loop_increment, prefer_early_return, prefer_immutable_bloc_events, prefer_immutable_bloc_state, prefer_iterable_of, prefer_multi_bloc_provider, prefer_multi_provider, prefer_named_boolean_parameters, prefer_nullable_provider_types, prefer_sealed_bloc_events, prefer_sealed_bloc_state, prefer_switch_expression, prefer_widget_private_members, unused_element, unused_field, unused_local_variable

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
