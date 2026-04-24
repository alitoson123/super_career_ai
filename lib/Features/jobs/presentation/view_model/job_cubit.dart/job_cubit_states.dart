import 'package:super_career_ai/Features/jobs/Domain/entities/jobs_entity.dart';

abstract class JobCubitStates {}

class JobInitial extends JobCubitStates {}

class JobFetchLoading extends JobCubitStates {}

class JobFetchSuccess extends JobCubitStates {
  final List<JobEntity> jobs;
  JobFetchSuccess({required this.jobs});
}

class JobFetchFailure extends JobCubitStates {
  final String errorMessage;
  JobFetchFailure({required this.errorMessage});
}
