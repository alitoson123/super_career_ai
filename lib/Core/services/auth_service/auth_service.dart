import 'package:dio/dio.dart';
import 'package:super_career_ai/Core/network/backend_urls.dart';
import 'package:super_career_ai/Core/services/auth_token_storage/auth_token_storage.dart';

class AuthService {
  AuthService({Dio? dio, AuthTokenStorage? tokenStorage})
      : _tokenStorage = tokenStorage ?? AuthTokenStorage(),
        _dio = dio ??
            Dio(
              BaseOptions(
                connectTimeout: const Duration(seconds: 20),
                receiveTimeout: const Duration(seconds: 20),
                sendTimeout: const Duration(seconds: 20),
                headers: const {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                },
              ),
            );

  final Dio _dio;
  final AuthTokenStorage _tokenStorage;

  AuthTokenStorage get _storage => _tokenStorage;

  Future<void> _persistTokensFromResponse(dynamic data) async {
    if (data is! Map) return;
    final map = Map<String, dynamic>.from(data);

    // Backend is expected to return access/refresh (JWT),
    // but schema may not reflect it. Support common keys.
    final access = (map['access'] ?? map['token'] ?? map['access_token'])?.toString();
    final refresh = (map['refresh'] ?? map['refresh_token'])?.toString();
    await _storage.saveTokens(
      accessToken: access,
      refreshToken: refresh,
    );
  }

  Never _rethrowAsReadable(DioException e) {
    final status = e.response?.statusCode;
    final data = e.response?.data;
    final msg = [
      if (status != null) 'HTTP $status',
      if (data != null) data is String ? data : data.toString(),
      if ((data == null || data.toString().isEmpty) && (e.message?.isNotEmpty ?? false))
        e.message!,
    ].join(' - ');
    throw Exception(msg.isEmpty ? 'Request failed.' : msg);
  }

  Future<dynamic> registerUser({
    required String username,
    required String email,
    required String password,
    required String role,
    required String fullName,
    List<String>? skills,
    String? hourlyRate,
    String? specialization,
    String? experience,
    String? bio,
    String? education,
    String? preferences,
  }) async {
    try {
      final response = await _dio.post(
        BackendUrls.register,
        data: {
          'username': username,
          'email': email,
          'password': password,
          'role': role,
          'full_name': fullName,
          // Backend currently throws 500 if profile fields are missing/null.
          // Until backend is fixed, always send safe defaults.
          'skills': skills ?? const <String>[],
          'hourly_rate': hourlyRate ?? '0.00',
          'specialization': specialization ?? '',
          'experience': experience ?? '',
          'bio': bio ?? '',
          'education': education ?? '',
          'preferences': preferences ?? '',
        },
      );
      await _persistTokensFromResponse(response.data);
      return response.data;
    } on DioException catch (e) {
      _rethrowAsReadable(e);
    }
  }

  Future<dynamic> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        BackendUrls.login,
        data: {
          'email': email,
          'password': password,
        },
      );
      await _persistTokensFromResponse(response.data);
      return response.data;
    } on DioException catch (e) {
      _rethrowAsReadable(e);
    }
  }

/*
  Future<dynamic> googleRegister({
    required String idToken,
    required String role,
  }) async {
    try {
      final response = await _dio.post(
        BackendUrls.authGoogleRegister,
        data: {
          'id_token': idToken,
          'role': role,
        },
      );
      return response.data;
    } on DioException catch (e) {
      _rethrowAsReadable(e);
    }
  }

  Future<dynamic> googleLogin({
    required String idToken,
    required String role,
  }) async {
    try {
      final response = await _dio.post(
        BackendUrls.authGoogleLogin,
        data: {
          'id_token': idToken,
          'role': role,
        },
      );
      return response.data;
    } on DioException catch (e) {
      _rethrowAsReadable(e);
    }
  }
  */
}