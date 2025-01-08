part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

final class StartAuthen extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

final class RegisterAccount extends AuthenticationEvent {
  final String userName;
  final String password;
  final String email;
  final String roleName;
  final String phoneNumber;

  RegisterAccount(
      {required this.userName,
      required this.password,
      required this.email,
      required this.roleName,
      required this.phoneNumber});

  @override
  List<Object?> get props => [userName, password, email, roleName, phoneNumber];
}

final class LoginAccount extends AuthenticationEvent {
  final String emailOrUsername;
  final String password;

  LoginAccount({required this.emailOrUsername, required this.password});

  @override
  List<Object?> get props => [emailOrUsername, password];
}

final class LogoutAccount extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

final class LoginGmail extends AuthenticationEvent {
  LoginGmail();
  @override
  List<Object?> get props => [];
}
