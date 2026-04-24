import 'package:super_career_ai/Core/errors/failure.dart';
import 'package:super_career_ai/Features/Projects/Domain/entities/project_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProjectRepo {
  Future<Either<Failure,List<ProjectEntity>>> fetchProjectMatches();
}
