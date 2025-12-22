import 'package:bloc/bloc.dart';

sealed class DataEvent {}

final class FetchDataEvent extends DataEvent {}

sealed class DataState {}

final class DataInitial extends DataState {}

// Adding event with isClosed check - should not trigger lint
class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(DataInitial()) {
    on<FetchDataEvent>((event, emit) async {
      await Future.delayed(const Duration(seconds: 1));
      if (!isClosed) {
        add(FetchDataEvent());
      }
    });
  }
}

// No async gap before add
class SyncBloc extends Bloc<DataEvent, DataState> {
  SyncBloc() : super(DataInitial()) {
    on<FetchDataEvent>((event, emit) {
      add(FetchDataEvent());
    });
  }
}

// Using emit instead of add
class EmitBloc extends Bloc<DataEvent, DataState> {
  EmitBloc() : super(DataInitial()) {
    on<FetchDataEvent>((event, emit) async {
      await Future.delayed(const Duration(seconds: 1));
      emit(DataInitial());
    });
  }
}

// Multiple async gaps with proper checks
class SafeBloc extends Bloc<DataEvent, DataState> {
  SafeBloc() : super(DataInitial()) {
    on<FetchDataEvent>((event, emit) async {
      await Future.delayed(const Duration(seconds: 1));
      if (!isClosed) {
        add(FetchDataEvent());
      }

      await Future.delayed(const Duration(seconds: 1));
      if (!isClosed) {
        add(FetchDataEvent());
      }
    });
  }
}
