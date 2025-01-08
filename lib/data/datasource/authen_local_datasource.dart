import 'package:shared_preferences/shared_preferences.dart';

class AuthenLocalDataSource {
  AuthenLocalDataSource();

  // save method
  static Future<void> saveToken(String token) async {
    final sf = await SharedPreferences.getInstance();
    await sf.setString('token', token);
  }

  static Future<void> saveRefreshToken(String refreshToken) async {
    final sf = await SharedPreferences.getInstance();
    await sf.setString('refreshToken', refreshToken);
  }

  // get method
  static Future<String?> getToken() async {
    final sf = await SharedPreferences.getInstance();
    String? token = sf.getString('token');
    return token;
  }

  static Future<String?> getRefreshToken() async {
    final sf = await SharedPreferences.getInstance();
    String? refreshToken = sf.getString('refreshToken');
    return refreshToken;
  }

  // clear method
  static Future<void> clearToken() async {
    final sf = await SharedPreferences.getInstance();
    await sf.remove('token');
  }

  static Future<void> clearRefreshToken() async {
    final sf = await SharedPreferences.getInstance();
    await sf.remove('refreshToken');
  }

  static Future<void> saveUserId(String userId) async {
    final sf = await SharedPreferences.getInstance();
    await sf.setString('userId', userId);
  }

  static Future<String?> getUserId() async {
    final sf = await SharedPreferences.getInstance();
    String? userId = sf.getString('userId');
    return userId;
  }
}
