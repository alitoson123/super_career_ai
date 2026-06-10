import 'package:super_career_ai/Core/network/backend_urls.dart';
import 'package:super_career_ai/Core/services/dio_service.dart/dio_service.dart';
import 'package:super_career_ai/Features/jobs/Data/models/base_cv_model/base_cv_model.dart';

class BaseCVService {
  final DioService dioService;

  BaseCVService({required this.dioService});

  Future<BaseCvModel> getBaseCV() async {
    final result = await dioService.getMethodMap(url: BackendUrls.getBaseCV);

    final baseCvModel = BaseCvModel.fromJson(result);

    return baseCvModel;
  }

  ///////////////////////////////////
  Future<BaseCvModel> uploadBaseCVForTheFirstTime(
    Map<String, dynamic> data,
  ) async {
    final result = await dioService.postMethodMap(
      url: BackendUrls.uploadBaseCV,
      data: data,
    );

    final baseCvModel = BaseCvModel.fromJson(result);

    return baseCvModel;
  }

  Future<BaseCvModel> changeTheBaseCV(Map<String, dynamic> data) async {
    final result = await dioService.putMethodMap(
      url: BackendUrls.changeBaseCV,
      data: data,
    );

    final baseCvModel = BaseCvModel.fromJson(result);

    return baseCvModel;
  }
}
