import 'package:dio/dio.dart';
import 'package:super_career_ai/Core/network/backend_urls.dart';
import 'package:super_career_ai/Core/services/auth_token_storage/auth_token_storage.dart';
import 'package:super_career_ai/Features/profile/data/models/profile_model.dart';

class ProfileService {
  ProfileService({Dio? dio, AuthTokenStorage? tokenStorage})
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
            ),
        _tokenStorage = tokenStorage ?? AuthTokenStorage();

  final Dio _dio;
  final AuthTokenStorage _tokenStorage;

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

  Future<ProfileModel> fetchMyProfile() async {
    final token = await _tokenStorage.getAccessToken();
    if (token == null || token.isEmpty) {
      throw Exception('Missing auth token. Please login again.');
    }

    try {
      final res = await _dio.get(
        BackendUrls.profile,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      final data = Map<String, dynamic>.from(res.data as Map);
      return ProfileModel.fromJson(data);
    } on DioException catch (e) {
      _rethrowAsReadable(e);
    }
  }

  Future<ProfileModel> updateMyProfile({
    required String fullName,
    required String professionalTitle,
    required String email,
  }) async {
    final token = await _tokenStorage.getAccessToken();
    if (token == null || token.isEmpty) {
      throw Exception('Missing auth token. Please login again.');
    }

    try {
      final res = await _dio.patch(
        BackendUrls.profile,
        data: {
          'full_name': fullName,
          'professional_title': professionalTitle,
          'email': email,
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      final data = Map<String, dynamic>.from(res.data as Map);
      return ProfileModel.fromJson(data);
    } on DioException catch (e) {
      _rethrowAsReadable(e);
    }
  }
}

