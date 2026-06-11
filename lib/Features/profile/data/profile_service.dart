import 'package:dio/dio.dart';
import 'package:super_career_ai/Core/network/backend_urls.dart';
import 'package:super_career_ai/Features/profile/data/models/profile_model.dart';

class ProfileService {
  final Dio _dio;

  ProfileService({required Dio dio}) : _dio = dio;

  Never _rethrowAsReadable(DioException e) {
    final status = e.response?.statusCode;
    final data = e.response?.data;
    final msg = [
      if (status != null) 'HTTP $status',
      if (data != null) data is String ? data : data.toString(),
      if ((data == null || data.toString().isEmpty) &&
          (e.message?.isNotEmpty ?? false))
        e.message!,
    ].join(' - ');
    throw Exception(msg.isEmpty ? 'Request failed.' : msg);
  }

  Future<ProfileModel> fetchMyProfile() async {
    try {
      final res = await _dio.get(BackendUrls.profile);
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
    try {
      final res = await _dio.patch(
        BackendUrls.profile,
        data: {
          'full_name': fullName,
          'professional_title': professionalTitle,
          'email': email,
        },
      );
      final data = Map<String, dynamic>.from(res.data as Map);
      return ProfileModel.fromJson(data);
    } on DioException catch (e) {
      _rethrowAsReadable(e);
    }
  }
}
