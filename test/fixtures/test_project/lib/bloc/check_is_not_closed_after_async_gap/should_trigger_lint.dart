import 'package:bloc/bloc.dart';

sealed class DataEvent {}

final class FetchDataEvent extends DataEvent {}

sealed class DataState {}

final class DataInitial extends DataState {}

// Adding event after async gap without isClosed check - should trigger lint
class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(DataInitial()) {
    on<FetchDataEvent>((event, emit) async {
      await Future.delayed(const Duration(seconds: 1));
      // expect_lint: check_is_not_closed_after_async_gap
      add(FetchDataEvent());
    });
  }
}

// Multiple async gaps without checks
class UserBloc extends Bloc<DataEvent, DataState> {
  UserBloc() : super(DataInitial()) {
    on<FetchDataEvent>((event, emit) async {
      await Future.delayed(const Duration(seconds: 1));
      // expect_lint: check_is_not_closed_after_async_gap
      add(FetchDataEvent());

      await Future.delayed(const Duration(seconds: 1));
      // expect_lint: check_is_not_closed_after_async_gap
      add(FetchDataEvent());
    });
  }
}
