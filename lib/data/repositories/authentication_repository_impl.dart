import 'package:dio/dio.dart';

import '../../../domain/repositories.dart';
import '../datasource/authen_local_datasource.dart';
import '../model.dart';
import '../utils/request.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  @override
  Future<AuthenModel?> loginWithGmail(
      CreateAuthenModel createAuthenModel) async {
    try {
      final response = await request.post(
        '/api/v1/account/create',
        data: createAuthenModel.toJson(),
      );

      if (response.statusCode == 200 && response.data != null) {
        return AuthenModel.fromJson(response.data);
      } else {
        print('Request failed with status: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      print('Dio error: ${e.response?.statusCode} - ${e.message}');
      return null;
    } catch (e) {
      print('Unexpected error: $e');
      rethrow;
    }
  }

  @override
  Future<AuthenModel?> registerAccount(
      CreateAuthenModel createAuthenModel) async {
    try {
      final response = await request.post(
        '/api/v1/account/create',
        data: createAuthenModel.toJson(),
      );

      if (response.statusCode == 200 && response.data != null) {
        return AuthenModel.fromJson(response.data);
      } else {
        print('Request failed with status: ${response.statusCode}');
        return null;
      }
    } on DioError catch (e) {
      print('Dio error: ${e.response?.statusCode} - ${e.message}');
      return null;
    } catch (e) {
      print('Unexpected error: $e');
      rethrow;
    }
  }

  @override
  Future<bool> login(LoginModel loginModel) async {
    try {
      final response = await request.post(
        '/auth/login',
        data: loginModel.toJson(),
      );

      if (response.statusCode == 200 && response.data != null) {
        AuthenLocalDataSource.saveToken(response.data['token']);
        AuthenLocalDataSource.saveUserId(response.data['id']);
        AuthenLocalDataSource.saveRefreshToken(response.data['refreshToken']);
        return true;
      } else {
        print('Request failed with status: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Unexpected error: $e');
      return false;
    }
  }
}
