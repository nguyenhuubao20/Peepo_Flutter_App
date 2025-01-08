part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}

// Trạng thái ban đầu
final class AuthenticationInitial extends AuthenticationState {}

// Trạng thái đang xử lý xác thực
final class AuthenticationInProcess extends AuthenticationState {}

// Trạng thái đang xử lý xác thực bằng Gmail
final class AuthenticationInProcessByGmail extends AuthenticationState {}

// Trạng thái đang xử lý xác thực bằng tài khoản
final class AuthenticationInProcessByAccount extends AuthenticationState {}

// Trạng thái xác thực thành công
final class AuthenticationSuccess extends AuthenticationState {}

// Trạng thái xác thực thất bại
final class AuthenticationFailed extends AuthenticationState {
  final String error; // Lưu thông báo lỗi
  const AuthenticationFailed({required this.error});

  @override
  List<Object?> get props => [error];
}
