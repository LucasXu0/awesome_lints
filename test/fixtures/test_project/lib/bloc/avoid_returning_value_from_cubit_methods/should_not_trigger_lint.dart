// ignore_for_file: unused_element, prefer_immutable_bloc_events, prefer_immutable_bloc_state, prefer_sealed_bloc_events, prefer_sealed_bloc_state, handle_bloc_event_subclasses, avoid_cubits, avoid_bloc_public_fields, avoid_bloc_public_methods, prefer_bloc_event_suffix, prefer_bloc_state_suffix, avoid_passing_build_context_to_blocs, unused_field, unused_local_variable, prefer_widget_private_members, newline_before_method, newline_before_constructor, avoid_duplicate_bloc_event_handlers, avoid_empty_build_when, avoid_existing_instances_in_bloc_provider, avoid_instantiating_in_bloc_value_provider, avoid_passing_bloc_to_bloc, check_is_not_closed_after_async_gap, emit_new_bloc_state_instances, prefer_bloc_extensions, prefer_correct_bloc_provider, prefer_multi_bloc_provider, no_empty_string, avoid_async_call_in_sync_function, avoid_default_tostring, no_empty_block, arguments_ordering, dispose_providers, avoid_unnecessary_stateful_widgets, prefer_multi_provider, avoid_duplicate_collection_elements

import 'package:bloc/bloc.dart';

// Cubit methods with void return type - should not trigger lint
class UserCubit extends Cubit<String> {
  UserCubit() : super('');

  void updateUser(String name) {
    emit(name);
  }

  Future<void> fetchUser() async {
    emit('user');
  }

  void deleteUser() {
    emit('');
  }
}

// Getters are allowed
class DataCubit extends Cubit<int> {
  DataCubit() : super(0);

  int get currentValue => state;

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}

// Private methods with return values are allowed
class SettingsCubit extends Cubit<Map<String, dynamic>> {
  SettingsCubit() : super({});

  bool _isValid() {
    return true;
  }

  String _getValue() {
    return '';
  }

  void updateSettings() {
    if (_isValid()) {
      emit({'value': _getValue()});
    }
  }
}

// Override methods are allowed
class CustomCubit extends Cubit<String> {
  CustomCubit() : super('');

  @override
  Future<void> close() {
    return super.close();
  }
}
