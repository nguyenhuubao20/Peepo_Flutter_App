part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

// Trạng thái ban đầu
final class HomeInitial extends HomeState {}

// Trạng thái đang xử lý
final class HomeInProcess extends HomeState {}
