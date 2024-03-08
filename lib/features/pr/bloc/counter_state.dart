part of 'counter_bloc.dart';

@immutable
sealed class CounterState{
  CounterState();
}
final class CounterInitial extends CounterState{
  CounterInitial();
}
final class CounterLoading extends CounterState{
  CounterLoading();
}
final class CounterSuccess extends CounterState{
  CounterSuccess();
}