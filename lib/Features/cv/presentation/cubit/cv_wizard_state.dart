import 'package:super_career_ai/Features/cv/domain/entities/cv_entity.dart';
import 'package:super_career_ai/Features/cv/domain/entities/ats_analysis_entity.dart';

enum CvWizardStep { personalInfo, workExperience, education, skills, atsResult }

class CvWizardState {
  const CvWizardState({
    required this.step,
    required this.cv,
    required this.atsAnalysis,
    required this.isLoading,
    this.errorMessage,
  });

  final CvWizardStep step;
  final CvEntity cv;
  final AtsAnalysisEntity? atsAnalysis;
  final bool isLoading;
  final String? errorMessage;

  static CvWizardState initial() => CvWizardState(
    step: CvWizardStep.personalInfo,
    cv: CvEntity(
      personalInfo: PersonalInfoEntity.empty(),
      workExperiences: [WorkExperienceEntity.empty()],
      educations: [EducationEntity.empty()],
      skills: const [],
    ),
    atsAnalysis: null,
    isLoading: false,
  );

  CvWizardState copyWith({
    CvWizardStep? step,
    CvEntity? cv,
    AtsAnalysisEntity? atsAnalysis,
    bool? isLoading,
    String? errorMessage,
  }) {
    return CvWizardState(
      step: step ?? this.step,
      cv: cv ?? this.cv,
      atsAnalysis: atsAnalysis ?? this.atsAnalysis,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
