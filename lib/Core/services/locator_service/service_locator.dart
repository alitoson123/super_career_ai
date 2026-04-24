import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:super_career_ai/Core/services/dio_service.dart/dio_service.dart';
import 'package:super_career_ai/Core/services/match_service.dart/match_service.dart';
import 'package:super_career_ai/Features/Projects/Data/repo_impl/project_repo_impl.dart';
import 'package:super_career_ai/Features/jobs/Data/repo_impl/job_repo_impl.dart';

final getIt = GetIt.instance;
final Dio dio = Dio();

void setup() {
  // 1. Register AppServices first
  getIt.registerLazySingleton<DioService>(() => DioService(dio: dio));

  //  Register AI Card Feature dependencies
  getIt.registerLazySingleton<JobRepoImpl>(
    () => JobRepoImpl(
      matchService: MatchService(dioService: getIt<DioService>()),
    ),
  );
   getIt.registerLazySingleton<ProjectRepoImpl>(
    () => ProjectRepoImpl(
      matchService: MatchService(dioService: getIt<DioService>()),
    ),
  );
}
