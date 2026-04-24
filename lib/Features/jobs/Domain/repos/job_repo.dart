import 'package:super_career_ai/Core/errors/failure.dart';
import 'package:super_career_ai/Features/jobs/Domain/entities/jobs_entity.dart';
import 'package:dartz/dartz.dart';

abstract class JobRepo {
  Future<Either<Failure,List<JobEntity>>> fetchJobMatches();
}
