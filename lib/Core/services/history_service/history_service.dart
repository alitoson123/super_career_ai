import 'package:super_career_ai/Core/network/backend_urls.dart';
import 'package:super_career_ai/Core/services/dio_service.dart/dio_service.dart';
import 'package:super_career_ai/Features/jobs/Data/models/base_cv_model/base_cv_model.dart';

class HistoryService {
  final DioService dioService;

  HistoryService({required this.dioService});

  Future<List<BaseCvModel>> customCVHistory() async {
    final result = await dioService.getMethodList(
      url: BackendUrls.customCVHistory,
    );

    return result
        .map((e) => BaseCvModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
