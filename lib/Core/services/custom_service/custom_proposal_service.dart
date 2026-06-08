import 'package:super_career_ai/Core/network/backend_urls.dart';
import 'package:super_career_ai/Core/services/dio_service.dart/dio_service.dart';

class CustomProposalService {
  final DioService dioService;

  CustomProposalService({required this.dioService});

  Future<String> customProposal({required int project_id}) async {
    final result = await dioService.postMethodMap(
      url: BackendUrls.customProposal,
      data: {"job_id": null, "project_id": project_id},
    );

    return result['proposal'];
  }
}
