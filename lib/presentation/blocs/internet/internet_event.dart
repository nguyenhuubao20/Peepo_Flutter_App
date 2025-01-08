part of 'internet_bloc.dart';

sealed class InternetEvent extends Equatable {
  const InternetEvent();
}

final class OnConnected extends InternetEvent {
  @override
  List<Object?> get props => [];
}

final class OnNotConnected extends InternetEvent{
    @override
  List<Object?> get props => [];
}
