import 'package:super_career_ai/Core/network/backend_urls.dart';
import 'package:super_career_ai/Core/services/dio_service.dart/dio_service.dart';
import 'package:super_career_ai/Features/jobs/Data/models/base_cv_model/base_cv_model.dart';

class CustomCVService {
  final DioService dioService;

  CustomCVService({required this.dioService});

  Future<BaseCvModel> customCVJob({required int jobId}) async {
    final result = await dioService.postMethodMap(
      url: '${BackendUrls.customCVJob}$jobId/',
      data: {},
    );

    return BaseCvModel.fromJson(result);
  }
}
