import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_career_ai/Features/cv/domain/entities/ats_analysis_entity.dart';
import 'package:super_career_ai/Features/cv/domain/entities/cv_entity.dart';
import 'cv_wizard_state.dart';

/// Drives the multi-step CV wizard. Each public method corresponds to a
/// user action (saving a step, adding/removing items, toggling skills, etc.).
class CvWizardCubit extends Cubit<CvWizardState> {
  CvWizardCubit() : super(CvWizardState.initial());

  // ──────────────────────────── Navigation ────────────────────────────

  void goToStep(CvWizardStep step) => emit(state.copyWith(step: step));

  // ────────────────────────── Personal Info ───────────────────────────

  void savePersonalInfo(PersonalInfoEntity info) {
    emit(
      state.copyWith(
        cv: state.cv.copyWith(personalInfo: info),
        step: CvWizardStep.workExperience,
      ),
    );
  }

  // ───────────────────────── Work Experience ──────────────────────────

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

  void saveWorkExperience() =>
      emit(state.copyWith(step: CvWizardStep.education));

  // ──────────────────────────── Education ─────────────────────────────

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

  // ──────────────────────────── Skills ────────────────────────────────

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

  /// Simulate ATS analysis (would hit a real API in production).
  Future<void> submitSkillsAndAnalyze() async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(milliseconds: 800));

    final analysis = AtsAnalysisEntity(
      matchScore: 85,
      keywordsFound: 12,
      totalKeywords: 15,
      improvementTips: [
        const ImprovementTipEntity(
          title: 'Quantify Achievements',
          description:
              "Add more metrics like 'Increased conversion by 20%' "
              'to strengthen impact.',
          isWarning: true,
        ),
        const ImprovementTipEntity(
          title: 'Missing Core Skill',
          description:
              "The job description mentions 'Agile Methodology' frequently. "
              'Consider adding this to your skills.',
          isWarning: false,
        ),
      ],
    );

    emit(
      state.copyWith(
        isLoading: false,
        atsAnalysis: analysis,
        step: CvWizardStep.atsResult,
      ),
    );
  }

  void restart() => emit(CvWizardState.initial());
}
