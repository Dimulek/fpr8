part of 'counter_cubit.dart';

@immutable
sealed class CounterState{
  final List<PrEntity> prList;
  const CounterState({required this.prList});
}
final class CounterInitial extends CounterState{
  const CounterInitial({required super.prList});
}
final class CounterLoading extends CounterState{
  const CounterLoading({required super.prList});
}
final class CounterException extends CounterState{
  const CounterException({required super.prList});
}
final class CounterSuccess extends CounterState{
  const CounterSuccess({required super.prList});
}