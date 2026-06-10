import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:super_career_ai/Core/services/custom_service/custom_cv_service.dart';
import 'package:super_career_ai/Core/services/custom_service/custom_proposal_service.dart';
import 'package:super_career_ai/Core/services/cv_service/base_cv_service.dart';
import 'package:super_career_ai/Core/services/dio_service.dart/dio_service.dart';
import 'package:super_career_ai/Core/services/history_service/history_service.dart';
import 'package:super_career_ai/Core/services/match_service.dart/match_service.dart';
import 'package:super_career_ai/Features/Projects/Data/repo_impl/project_repo_impl.dart';
import 'package:super_career_ai/Features/jobs/Data/repo_impl/job_repo_impl.dart';

import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;
final Dio dio = Dio();

Future<void> setup() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => prefs);

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = prefs.getString('auth_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ),
  );

  // 1. Register AppServices first
  getIt.registerLazySingleton<DioService>(() => DioService(dio: dio));

  //  Register AI Card Feature dependencies
  getIt.registerLazySingleton<JobRepoImpl>(
    () => JobRepoImpl(
      matchService: MatchService(dioService: getIt<DioService>()),
      historyService: HistoryService(dioService: getIt<DioService>()),
      baseCvService: BaseCVService(dioService: getIt<DioService>()),
      customCVService: CustomCVService(dioService: getIt<DioService>()),
    ),
  );
  getIt.registerLazySingleton<ProjectRepoImpl>(
    () => ProjectRepoImpl(
      matchService: MatchService(dioService: getIt<DioService>()),
      customProposalService: CustomProposalService(
        dioService: getIt<DioService>(),
      ),
    ),
  );
}
