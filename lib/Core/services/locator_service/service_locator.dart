import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_career_ai/Core/services/custom_service/custom_cv_service.dart';
import 'package:super_career_ai/Core/services/custom_service/custom_proposal_service.dart';
import 'package:super_career_ai/Core/services/cv_service/base_cv_service.dart';
import 'package:super_career_ai/Core/services/dio_service.dart/dio_service.dart';
import 'package:super_career_ai/Core/services/history_service/history_service.dart';
import 'package:super_career_ai/Core/services/match_service.dart/match_service.dart';
import 'package:super_career_ai/Features/Projects/Data/repo_impl/project_repo_impl.dart';
import 'package:super_career_ai/Features/jobs/Data/repo_impl/job_repo_impl.dart';
import 'package:super_career_ai/Features/profile/data/profile_service.dart';
import 'package:super_career_ai/Features/profile/presentation/cubit/profile_cubit.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => prefs);

  // 1. Register Dio
  final Dio dio = Dio();
  dio.options = BaseOptions(
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = getIt<SharedPreferences>().getString('auth_token');
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) {
        if (e.response?.statusCode == 401) {
          print('Unauthorized request - 401');
        }
        return handler.next(e);
      },
    ),
  );

  getIt.registerLazySingleton<Dio>(() => dio);

  // 2. Register AppServices
  getIt.registerLazySingleton<DioService>(() => DioService(dio: getIt<Dio>()));
  getIt.registerLazySingleton<ProfileService>(() => ProfileService(dio: getIt<Dio>()));

  // 3. Register Repos
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

  // 4. Register Cubits
  getIt.registerFactory<ProfileCubit>(() => ProfileCubit(service: getIt<ProfileService>()));
}
