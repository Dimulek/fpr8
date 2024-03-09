part of 'counter_bloc.dart';

@immutable
sealed class CounterEvent {}

final class OnClickEvent extends CounterEvent {}

final class OnComplite extends CounterEvent {}

final class OnReload extends CounterEvent {}