import 'package:super_career_ai/Features/jobs/Data/models/base_cv_model/base_cv_model.dart';

abstract class UploadBaseCvStates {}

class UploadBaseCvInitial extends UploadBaseCvStates {}

class UploadBaseCvLoading extends UploadBaseCvStates {}

class UploadBaseCvSuccess extends UploadBaseCvStates {
  final BaseCvModel? baseCv;
  UploadBaseCvSuccess({this.baseCv});
}

class UploadBaseCvFailure extends UploadBaseCvStates {
  final String errorMessage;
  UploadBaseCvFailure({required this.errorMessage});
}
