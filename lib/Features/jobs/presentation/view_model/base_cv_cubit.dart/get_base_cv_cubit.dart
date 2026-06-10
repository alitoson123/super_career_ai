import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_career_ai/Features/jobs/Domain/repos/job_repo.dart';
import 'package:super_career_ai/Features/jobs/presentation/view_model/base_cv_cubit.dart/get_base_cv_states.dart';

class BaseCvCubit extends Cubit<BaseCvStates> {
  BaseCvCubit({required this.jobRepo}) : super(BaseCvInitial());
  final JobRepo jobRepo;

  Future<void> fetchBaseCV() async {
    emit(BaseCvLoading());
    final result = await jobRepo.getBaseCV();
    result.fold(
      (failure) {
        emit(BaseCvFailure(errorMessage: failure.errorMessage));
      },
      (baseCv) {
        emit(BaseCvSuccess(baseCv: baseCv));
      },
    );
  }
}
