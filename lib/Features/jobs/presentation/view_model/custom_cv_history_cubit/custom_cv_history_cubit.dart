import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_career_ai/Features/jobs/Domain/repos/job_repo.dart';
import 'package:super_career_ai/Features/jobs/presentation/view_model/custom_cv_history_cubit/custom_cv_history_states.dart';

class CustomCvHistoryCubit extends Cubit<CustomCvHistoryStates> {
  CustomCvHistoryCubit({required this.jobRepo})
    : super(CustomCvHistoryInitial());
  final JobRepo jobRepo;

  Future<void> fetchCustomCvHistory() async {
    emit(CustomCvHistoryLoading());
    final result = await jobRepo.customCVHistory();
    result.fold(
      (failure) {
        emit(CustomCvHistoryFailure(errorMessage: failure.errorMessage));
      },
      (cvs) {
        emit(CustomCvHistorySuccess(cvs: cvs));
      },
    );
  }
}
