part of 'counter_bloc.dart';

@immutable
sealed class CounterEvent {}

final class OnClickEvent extends CounterEvent {}