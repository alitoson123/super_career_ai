import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_career_ai/Features/jobs/Domain/repos/job_repo.dart';
import 'package:super_career_ai/Features/jobs/presentation/view_model/job_cubit.dart/job_cubit_states.dart';

class JobCubit extends Cubit<JobCubitStates> {
  JobCubit({required this.jobRepo}) : super(JobInitial());

  final JobRepo jobRepo;

  Future<void> fetchJobMatches(
    //{bool forceRefresh = false}
  ) async {
    // if (state is JobFetchSuccess && !forceRefresh) return;
    //  if (state is JobFetchLoading) return;

    emit(JobFetchLoading());
    final result = await jobRepo.fetchJobMatches();
    result.fold(
      (failure) => emit(JobFetchFailure(errorMessage: failure.errorMessage)),
      (jobs) => emit(JobFetchSuccess(jobs: jobs)),
    );
  }
}
