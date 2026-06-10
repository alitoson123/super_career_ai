import 'package:super_career_ai/Features/jobs/Data/models/base_cv_model/base_cv_model.dart';

abstract class CreateCustomCvStates {}

class CreateCustomCvInitial extends CreateCustomCvStates {}

class CreateCustomCvLoading extends CreateCustomCvStates {}

class CreateCustomCvSuccess extends CreateCustomCvStates {
  final BaseCvModel cvModel;

  CreateCustomCvSuccess({required this.cvModel});
}

class CreateCustomCvFailure extends CreateCustomCvStates {
  final String errorMessage;

  CreateCustomCvFailure({required this.errorMessage});
}
