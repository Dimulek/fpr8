import 'package:bloc/bloc.dart';
import 'package:fpr8/features/pr/cubit/counter_cubit.dart';
import 'package:fpr8/features/pr/domain/entity/pr_entity.dart';
import 'package:meta/meta.dart';

part 'counter_even.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterCubit cubit;
  CounterBloc({required this.cubit}) : super(CounterInitial()){
    on<OnClickEvent>((even, emit){
      emit(CounterLoading());
    });
    on<OnComplite>((even, emit){
      emit(CounterSuccess());
    });
    on<OnReload>((even, emit){
      emit(CounterInitial());
    });
  }
}