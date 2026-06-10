import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_career_ai/Features/jobs/Domain/repos/job_repo.dart';
import 'create_custom_cv_states.dart';

class CreateCustomCvCubit extends Cubit<CreateCustomCvStates> {
  final JobRepo jobRepo;

  CreateCustomCvCubit({required this.jobRepo}) : super(CreateCustomCvInitial());

  Future<void> createCustomCV({required int jobId}) async {
    emit(CreateCustomCvLoading());

    final result = await jobRepo.customCVJob(jobId: jobId);

    result.fold(
      (failure) {
        emit(CreateCustomCvFailure(errorMessage: failure.errorMessage));
      },
      (cvModel) {
        emit(CreateCustomCvSuccess(cvModel: cvModel));
      },
    );
  }
}
