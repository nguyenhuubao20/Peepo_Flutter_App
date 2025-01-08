import 'package:peefo/data/models/authen/login_model.dart';

import '../../data/models/authen/authen_model.dart';
import '../../data/models/authen/create_authen_model.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  Future<AuthenModel?> loginWithGmail(CreateAuthenModel createAuthenModel);

  Future<AuthenModel?> registerAccount(CreateAuthenModel createAuthenModel);

  Future<bool> login(LoginModel loginModel);
}
