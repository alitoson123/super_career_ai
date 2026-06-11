import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_career_ai/Core/network/backend_urls.dart';
import 'package:super_career_ai/Core/services/dio_service.dart/dio_service.dart';
import 'package:super_career_ai/Features/cv/domain/entities/ats_analysis_entity.dart';
import 'package:super_career_ai/Features/cv/domain/entities/cv_entity.dart';
import 'cv_wizard_state.dart';

class CvWizardCubit extends Cubit<CvWizardState> {
  final DioService dioService;

  CvWizardCubit({required this.dioService}) : super(CvWizardState.initial());

  void goToStep(CvWizardStep step) => emit(state.copyWith(step: step));

  void savePersonalInfo(PersonalInfoEntity info) {
    emit(state.copyWith(
      cv: state.cv.copyWith(personalInfo: info),
      step: CvWizardStep.workExperience,
    ));
  }

  void updateWorkExperience(int index, WorkExperienceEntity experience) {
    final updated = List<WorkExperienceEntity>.from(state.cv.workExperiences);
    updated[index] = experience;
    emit(state.copyWith(cv: state.cv.copyWith(workExperiences: updated)));
  }

  void addWorkExperience() {
    final updated = List<WorkExperienceEntity>.from(state.cv.workExperiences)
      ..add(WorkExperienceEntity.empty());
    emit(state.copyWith(cv: state.cv.copyWith(workExperiences: updated)));
  }

  void removeWorkExperience(int index) {
    if (state.cv.workExperiences.length <= 1) return;
    final updated = List<WorkExperienceEntity>.from(state.cv.workExperiences)
      ..removeAt(index);
    emit(state.copyWith(cv: state.cv.copyWith(workExperiences: updated)));
  }

  void saveWorkExperience() => emit(state.copyWith(step: CvWizardStep.education));

  void updateEducation(int index, EducationEntity education) {
    final updated = List<EducationEntity>.from(state.cv.educations);
    updated[index] = education;
    emit(state.copyWith(cv: state.cv.copyWith(educations: updated)));
  }

  void addEducation() {
    final updated = List<EducationEntity>.from(state.cv.educations)
      ..add(EducationEntity.empty());
    emit(state.copyWith(cv: state.cv.copyWith(educations: updated)));
  }

  void removeEducation(int index) {
    if (state.cv.educations.length <= 1) return;
    final updated = List<EducationEntity>.from(state.cv.educations)
      ..removeAt(index);
    emit(state.copyWith(cv: state.cv.copyWith(educations: updated)));
  }

  void saveEducation() => emit(state.copyWith(step: CvWizardStep.skills));

  void addSkill(String skill) {
    final trimmed = skill.trim();
    if (trimmed.isEmpty || state.cv.skills.contains(trimmed)) return;
    final updated = List<String>.from(state.cv.skills)..add(trimmed);
    emit(state.copyWith(cv: state.cv.copyWith(skills: updated)));
  }

  void removeSkill(String skill) {
    final updated = List<String>.from(state.cv.skills)..remove(skill);
    emit(state.copyWith(cv: state.cv.copyWith(skills: updated)));
  }

  Future<void> submitSkillsAndAnalyze() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final requestData = state.cv.toJson();
      debugPrint('CV API Request: $requestData');

      final response = await dioService.postMethodMap(
        url: BackendUrls.analyzeCV,
        data: requestData,
      );

      debugPrint('CV API Response: $response');

      // Robustly parse the ATS score
      final dynamic rawScore = response['ats_score'] ?? response['score'] ?? 0;
      final int score = (rawScore is num) 
          ? rawScore.toInt() 
          : int.tryParse(rawScore.toString()) ?? 0;
      
      final analysis = AtsAnalysisEntity(
        matchScore: score,
        keywordsFound: response['keywords_found'] ?? 0,
        totalKeywords: response['total_keywords'] ?? 0,
        improvementTips: (response['feedback'] as List? ?? []).map((e) => ImprovementTipEntity(
          title: 'Feedback',
          description: e.toString(),
          isWarning: true,
        )).toList(),
      );

      emit(state.copyWith(
        isLoading: false,
        atsAnalysis: analysis,
        step: CvWizardStep.atsResult,
      ));
    } catch (e) {
      debugPrint('CV API Error: $e');
      emit(state.copyWith(
        isLoading: false,
        errorMessage: "Failed to analyze CV. Please try again.",
      ));
    }
  }

  void restart() => emit(CvWizardState.initial());
}
