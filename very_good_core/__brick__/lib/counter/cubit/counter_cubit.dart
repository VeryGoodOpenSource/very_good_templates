import 'package:bloc/bloc.dart';

class CounterCubit extends Cubit<int> {
  new() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}
