import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:super_career_ai/Core/errors/failure.dart';
import 'package:super_career_ai/Core/services/custom_service/custom_proposal_service.dart';
import 'package:super_career_ai/Core/services/match_service.dart/match_service.dart';
import 'package:super_career_ai/Features/Projects/Domain/entities/project_entity.dart';
import 'package:super_career_ai/Features/Projects/Domain/repos/project_repo.dart';

class ProjectRepoImpl extends ProjectRepo {
  final MatchService matchService;
  final CustomProposalService customProposalService;

  ProjectRepoImpl({
    required this.matchService,
    required this.customProposalService,
  });

  @override
  Future<Either<Failure, List<ProjectEntity>>> fetchProjectMatches() async {
    try {
      final result = await matchService.projectMatches();
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
  Future<Either<Failure, String>> customProposal({
    required int project_id,
  }) async {
    try {
      final result = await customProposalService.customProposal(
        project_id: project_id,
      );
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
