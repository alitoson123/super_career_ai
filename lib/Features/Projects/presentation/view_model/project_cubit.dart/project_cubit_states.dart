import 'package:super_career_ai/Features/Projects/Domain/entities/project_entity.dart';

abstract class ProjectCubitStates {}

class ProjectInitial extends ProjectCubitStates {}

class ProjectFetchLoading extends ProjectCubitStates {}

class ProjectFetchSuccess extends ProjectCubitStates {
  final List<ProjectEntity> projects;
  ProjectFetchSuccess({required this.projects});
}

class ProjectFetchFailure extends ProjectCubitStates {
  final String errorMessage;
  ProjectFetchFailure({required this.errorMessage});
}
