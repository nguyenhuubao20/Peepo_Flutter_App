import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:peefo/data/models/authen/create_authen_model.dart';
import 'package:peefo/data/models/authen/login_model.dart';

import '../../../domain/repositories.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;

  AuthenticationBloc({required this.authenticationRepository})
      : super(AuthenticationInitial()) {
    on<StartAuthen>(_onStartAuthen);
    on<RegisterAccount>(_onRegisterAccount);
    on<LoginAccount>(_onLoginAccount);
    // on<LoginGmail>(_onLoginGmail);
    // on<LogoutAccount>(_onLogoutAccount);
  }

  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/userinfo.profile',
    ],
  );

  // Khởi tạo trạng thái
  Future<void> _onStartAuthen(
      StartAuthen event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationInitial());
  }

  // Xử lý sự kiện đăng ký tài khoản
  Future<void> _onRegisterAccount(
      RegisterAccount event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationInProcess());
    try {
      final result = await authenticationRepository.registerAccount(
        CreateAuthenModel(
          userName: event.userName,
          password: event.password,
          email: event.email,
          roleName: event.roleName,
          phoneNumber: event.phoneNumber,
        ),
      );

      if (result != null) {
        emit(AuthenticationSuccess());
      } else {
        emit(AuthenticationFailed(
            error: 'Không thể đăng ký, vui lòng thử lại.'));
      }
    } catch (e) {
      emit(AuthenticationFailed(error: e.toString()));
    }
  }

  // Xử lý sự kiện đăng nhập bằng tài khoản
  Future<void> _onLoginAccount(
      LoginAccount event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationInProcess());
    try {
      final isSuccess = await authenticationRepository.login(
        LoginModel(
          emailOrUsername: event.emailOrUsername,
          password: event.password,
        ),
      );

      if (isSuccess) {
        emit(AuthenticationSuccess());
      } else {
        emit(AuthenticationFailed(
            error: 'Tên đăng nhập hoặc mật khẩu không đúng!'));
      }
    } catch (e) {
      emit(AuthenticationFailed(
          error: 'Đã có lỗi xảy ra, vui lòng thử lại: $e'));
    }
  }

  // Xử lý sự kiện đăng nhập bằng Gmail
  // Future<void> _onLoginGmail(
  //     LoginGmail event, Emitter<AuthenticationState> emit) async {
  //   emit(AuthenticationInProcessByGmail());
  //   await googleSignIn.signOut();
  //   try {
  //     final GoogleSignInAccount? userAccount = await googleSignIn.signIn();
  //     if (userAccount == null) {
  //       print('Đăng nhập bị hủy bởi người dùng.');
  //       return;
  //     }

  //     final idToken =
  //         await userAccount.authentication.then((value) => value.idToken);
  //     final result = await authenticationRepository.loginWithGmail(
  //       CreateAuthenModel(idToken: idToken),
  //     );

  //     if (result != null) {
  //       emit(AuthenticationSuccess());
  //     } else {
  //       emit(AuthenticationFailed(error: 'Không thể đăng nhập bằng Gmail.'));
  //     }
  //   } catch (e) {
  //     emit(AuthenticationFailed(error: e.toString()));
  //   }
  // }

  // Xử lý sự kiện đăng xuất
  // Future<void> _onLogoutAccount(
  //     LogoutAccount event, Emitter<AuthenticationState> emit) async {
  //   emit(AuthenticationInProcess());
  //   try {
  //     await authenticationRepository.logout();
  //     emit(AuthenticationLoggedOut());
  //   } catch (e) {
  //     emit(AuthenticationFailed(error: e.toString()));
  //   }
  // }
}
