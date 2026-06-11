import 'package:shared_preferences/shared_preferences.dart';

class AuthTokenStorage {
  static const _kAccessTokenKey = 'auth_token';
  static const _kRefreshTokenKey = 'auth_refresh_token';

  Future<void> saveTokens({String? accessToken, String? refreshToken}) async {
    final prefs = await SharedPreferences.getInstance();
    if (accessToken != null && accessToken.isNotEmpty) {
      await prefs.setString(_kAccessTokenKey, accessToken);
    }
    if (refreshToken != null && refreshToken.isNotEmpty) {
      await prefs.setString(_kRefreshTokenKey, refreshToken);
    }
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_kAccessTokenKey);
    return (token == null || token.isEmpty) ? null : token;
  }

  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_kRefreshTokenKey);
    return (token == null || token.isEmpty) ? null : token;
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kAccessTokenKey);
    await prefs.remove(_kRefreshTokenKey);
  }
}
