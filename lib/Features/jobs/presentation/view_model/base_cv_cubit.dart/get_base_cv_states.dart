import 'package:super_career_ai/Features/jobs/Data/models/base_cv_model/base_cv_model.dart';

abstract class BaseCvStates {}

class BaseCvInitial extends BaseCvStates {}

class BaseCvLoading extends BaseCvStates {}

class BaseCvSuccess extends BaseCvStates {
  final BaseCvModel? baseCv;
  BaseCvSuccess({this.baseCv});
}

class BaseCvFailure extends BaseCvStates {
  final String errorMessage;
  BaseCvFailure({required this.errorMessage});
}
