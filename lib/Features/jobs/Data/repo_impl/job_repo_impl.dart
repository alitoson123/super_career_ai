import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:super_career_ai/Core/errors/failure.dart';
import 'package:super_career_ai/Core/services/match_service.dart/match_service.dart';
import 'package:super_career_ai/Features/jobs/Domain/entities/jobs_entity.dart';
import 'package:super_career_ai/Features/jobs/Domain/repos/job_repo.dart';

class JobRepoImpl extends JobRepo {
  final MatchService matchService;

  JobRepoImpl({required this.matchService});

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
}
