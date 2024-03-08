part of 'counter_cubit.dart';

@immutable
sealed class CounterState{
  List<PrEntity> prList;
  CounterState({required this.prList});
}
final class CounterInitial extends CounterState{
  CounterInitial({required super.prList});
}
final class CounterLoading extends CounterState{
  CounterLoading({required super.prList});
}
final class CounterException extends CounterState{
  CounterException({required super.prList});
}
final class CounterSuccess extends CounterState{
  CounterSuccess({required super.prList});
}