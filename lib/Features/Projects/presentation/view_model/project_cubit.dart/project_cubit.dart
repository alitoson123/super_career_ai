import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_career_ai/Features/Projects/Domain/repos/project_repo.dart';
import 'package:super_career_ai/Features/Projects/presentation/view_model/project_cubit.dart/project_cubit_states.dart';

class ProjectCubit extends Cubit<ProjectCubitStates> {
  ProjectCubit({required this.projectRepo}) : super(ProjectInitial());

  final ProjectRepo projectRepo;

  Future<void> fetchProjectMatches() async {
    emit(ProjectFetchLoading());
    final result = await projectRepo.fetchProjectMatches();
    result.fold(
      (failure) => emit(ProjectFetchFailure(errorMessage: failure.errorMessage)),
      (projects) => emit(ProjectFetchSuccess(projects: projects)),
    );
  }
}
