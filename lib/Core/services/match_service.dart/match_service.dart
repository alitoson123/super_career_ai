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

    final jobList = result.map((e) => JobsModel.fromJson(e)).toList();
    jobList.sort((a, b) => b.matchScore.compareTo(a.matchScore));

    final Set<String> seenJobs = {};
    final uniqueJobs = jobList
        .where((job) {
          final key = '${job.title}_${job.company}'.toLowerCase();
          if (seenJobs.contains(key)) return false;
          seenJobs.add(key);
          return true;
        })
        .take(12)
        .toList();

    return uniqueJobs;
  }

  Future<List<ProjectModel>> projectMatches() async {
    final result = await dioService.getMethodList(
      url: BackendUrls.projectMatches,
    );

    final projectList = result.map((e) => ProjectModel.fromJson(e)).toList();
    projectList.sort((a, b) => b.matchScore.compareTo(a.matchScore));

    final Set<String> seenProjects = {};
    final uniqueProjects = projectList
        .where((project) {
          final key = '${project.title}_${project.platformName}'.toLowerCase();
          if (seenProjects.contains(key)) return false;
          seenProjects.add(key);
          return true;
        })
        .take(12)
        .toList();

    return uniqueProjects;
  }
}
