import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_career_ai/Features/Projects/Domain/repos/project_repo.dart';
import 'package:super_career_ai/Features/Projects/presentation/view_model/custom_proposal_cubit/custom_proposal_states.dart';

class CustomProposalCubit extends Cubit<CustomProposalStates> {
  CustomProposalCubit({required this.projectRepo})
    : super(CustomProposalInitial());

  final ProjectRepo projectRepo;

  Future<void> fetchCustomProposal({required int myProjectId}) async {
    emit(CustomProposalLoading());
    final result = await projectRepo.customProposal(project_id: myProjectId);
    result.fold(
      (failure) =>
          emit(CustomProposalFailure(errorMessage: failure.errorMessage)),
      (proposal) => emit(CustomProposalSuccess(proposal: proposal)),
    );
  }
}
