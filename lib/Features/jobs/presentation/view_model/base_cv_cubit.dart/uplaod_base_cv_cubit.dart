import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_career_ai/Features/jobs/Domain/repos/job_repo.dart';
import 'package:super_career_ai/Features/jobs/presentation/view_model/base_cv_cubit.dart/upload_base_cv_states.dart';

class UploadBaseCvCubit extends Cubit<UploadBaseCvStates> {
  UploadBaseCvCubit({required this.jobRepo}) : super(UploadBaseCvInitial());
  final JobRepo jobRepo;

  Future<void> uploadBaseCV({required Map<String, dynamic> data}) async {
    emit(UploadBaseCvLoading());
    final result = await jobRepo.uploadBaseCVForTheFirstTime(data);
    result.fold(
      (failure) {
        emit(UploadBaseCvFailure(errorMessage: failure.errorMessage));
      },
      (baseCv) {
        emit(UploadBaseCvSuccess(baseCv: baseCv));
      },
    );
  }
    Future<void> changeBaseCV({required Map<String, dynamic> data}) async {
    emit(UploadBaseCvLoading());
    final result = await jobRepo.changeTheBaseCV(data);
    result.fold(
      (failure) {
        emit(UploadBaseCvFailure(errorMessage: failure.errorMessage));
      },
      (baseCv) {
        emit(UploadBaseCvSuccess(baseCv: baseCv));
      },
    );
  }
}
