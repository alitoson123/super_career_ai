import 'package:super_career_ai/Core/network/backend_urls.dart';
import 'package:super_career_ai/Core/services/dio_service.dart/dio_service.dart';
import 'package:super_career_ai/Features/Projects/Data/models/project_model/project_model.dart';
import 'package:super_career_ai/Features/jobs/Data/models/jobs_model/jobs_model.dart';
import 'package:super_career_ai/Features/jobs/Domain/entities/jobs_entity.dart';

class MatchService {
  final DioService dioService;

  MatchService({required this.dioService});

  Future<List<JobEntity>> jobMatches() async {
    final result = await dioService.getMethodList(url: BackendUrls.jobMatches);

    final jobList = result.map((e) => JobsModel.fromJson(e)).take(10).toList();

    final filteredList = jobList.where((job) => job.matchScore >= 30).toList();

    return filteredList;
  }

  Future<List<ProjectModel>> projectMatches() async {
    final result = await dioService.getMethodList(
      url: BackendUrls.projectMatches,
    );

    final projectList = result
        .map((e) => ProjectModel.fromJson(e))
        .take(10)
        .toList();

    final filteredList = projectList
        .where((project) => project.matchScore >= 30)
        .toList();
    return filteredList;
  }
}
