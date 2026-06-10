import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:super_career_ai/Core/errors/failure.dart';
import 'package:super_career_ai/Core/services/cv_service/base_cv_service.dart';
import 'package:super_career_ai/Core/services/custom_service/custom_cv_service.dart';
import 'package:super_career_ai/Core/services/history_service/history_service.dart';
import 'package:super_career_ai/Core/services/match_service.dart/match_service.dart';
import 'package:super_career_ai/Features/jobs/Data/models/base_cv_model/base_cv_model.dart';
import 'package:super_career_ai/Features/jobs/Domain/entities/jobs_entity.dart';
import 'package:super_career_ai/Features/jobs/Domain/repos/job_repo.dart';

class JobRepoImpl extends JobRepo {
  final MatchService matchService;
  final HistoryService historyService;
  final BaseCVService baseCvService;
  final CustomCVService customCVService;

  JobRepoImpl({
    required this.matchService,
    required this.historyService,
    required this.baseCvService,
    required this.customCVService,
  });

  @override
  Future<Either<Failure, List<JobEntity>>> fetchJobMatches() async {
    try {
      final result = await matchService.jobMatches();
      return right(result);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(errorMessage: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<BaseCvModel>>> customCVHistory() async {
    try {
      final result = await historyService.customCVHistory();
      return right(result);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(errorMessage: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, BaseCvModel>> getBaseCV() async {
    try {
      final result = await baseCvService.getBaseCV();
      return right(result);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(errorMessage: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, BaseCvModel>> customCVJob({required int jobId}) async {
    try {
      print('Calling customCVJob with jobId: $jobId');
      final result = await customCVService.customCVJob(jobId: jobId);
      print('customCVJob result: $result');
      return right(result);
    } catch (e, stacktrace) {
      print('Error in customCVJob: $e');
      print('Stacktrace: $stacktrace');
      if (e is DioException) {
        print('DioException type: ${e.type}');
        print('DioException message: ${e.message}');
        print('DioException error: ${e.error}');
        print('DioException response: ${e.response?.data}');
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(errorMessage: e.toString()));
      }
    }
  }
}
