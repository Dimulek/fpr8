import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:fpr8/features/pr/domain/entity/pr_entity.dart';

part 'counter_even.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial()){
    on<OnClickEvent>((even, emit){
      emit(CounterLoading());
    });
  }
}