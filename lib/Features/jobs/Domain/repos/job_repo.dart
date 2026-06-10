import 'package:super_career_ai/Core/errors/failure.dart';
import 'package:super_career_ai/Features/jobs/Data/models/base_cv_model/base_cv_model.dart';
import 'package:super_career_ai/Features/jobs/Domain/entities/jobs_entity.dart';
import 'package:dartz/dartz.dart';

abstract class JobRepo {
  Future<Either<Failure, List<JobEntity>>> fetchJobMatches();

  Future<Either<Failure, List<BaseCvModel>>> customCVHistory();

  Future<Either<Failure, BaseCvModel>> getBaseCV();

  Future<Either<Failure, BaseCvModel>> customCVJob({required int jobId});

  Future<Either<Failure, BaseCvModel>> uploadBaseCVForTheFirstTime(Map<String, dynamic> data);

  Future<Either<Failure, BaseCvModel>> changeTheBaseCV(Map<String, dynamic> data);
}
