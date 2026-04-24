import 'package:dio/dio.dart';
import 'package:super_career_ai/Core/network/backend_urls.dart';

class AuthService {
  AuthService({Dio? dio})
      : _dio = dio ??
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