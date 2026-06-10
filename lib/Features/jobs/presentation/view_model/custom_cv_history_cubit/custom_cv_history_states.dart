import 'package:super_career_ai/Features/jobs/Data/models/base_cv_model/base_cv_model.dart';

abstract class CustomCvHistoryStates {}

class CustomCvHistoryInitial extends CustomCvHistoryStates {}

class CustomCvHistoryLoading extends CustomCvHistoryStates {}

class CustomCvHistorySuccess extends CustomCvHistoryStates {
  final List<BaseCvModel> cvs;
  CustomCvHistorySuccess({required this.cvs});
}

class CustomCvHistoryFailure extends CustomCvHistoryStates {
  final String errorMessage;
  CustomCvHistoryFailure({required this.errorMessage});
}
