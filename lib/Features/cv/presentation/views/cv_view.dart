import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/Core/constant/app_colors.dart';
import 'package:super_career_ai/Core/services/dio_service.dart/dio_service.dart';
import 'package:super_career_ai/Core/services/locator_service/service_locator.dart';
import 'package:super_career_ai/Features/cv/presentation/cubit/cv_wizard_cubit.dart';
import 'package:super_career_ai/Features/cv/presentation/cubit/cv_wizard_state.dart';
import 'package:super_career_ai/Features/cv/presentation/widgets/steps/ats_result_step.dart';
import 'package:super_career_ai/Features/cv/presentation/widgets/steps/education_step.dart';
import 'package:super_career_ai/Features/cv/presentation/widgets/steps/personal_info_step.dart';
import 'package:super_career_ai/Features/cv/presentation/widgets/steps/skills_step.dart';
import 'package:super_career_ai/Features/cv/presentation/widgets/steps/work_experience_step.dart';
import 'package:super_career_ai/generated/l10n.dart';

class CvView extends StatelessWidget {
  const CvView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CvWizardCubit(dioService: getIt<DioService>()),
      child: const _CvViewBody(),
    );
  }
}

class _CvViewBody extends StatelessWidget {
  const _CvViewBody();

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocBuilder<CvWizardCubit, CvWizardState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: _buildAppBar(context, state, s),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: _buildCurrentStep(context, state),
          ),
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context, CvWizardState state, S s) {
    final title = switch (state.step) {
      CvWizardStep.personalInfo => s.personalDetails,
      CvWizardStep.workExperience => s.workExperience,
      CvWizardStep.education => s.education,
      CvWizardStep.skills => s.skills,
      CvWizardStep.atsResult => s.atsAnalysis,
    };

    return AppBar(
      backgroundColor: AppColors.cardBackground,
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      leading: state.step != CvWizardStep.personalInfo
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.textPrimary,
              ),
              onPressed: () => _onBack(context, state),
            )
          : null,
      actions: [
        if (state.step == CvWizardStep.atsResult)
          IconButton(
            icon: const Icon(
              Icons.share_outlined,
              color: AppColors.textPrimary,
            ),
            onPressed: () {},
          ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.h),
        child: Container(height: 1.h, color: AppColors.border),
      ),
    );
  }

  void _onBack(BuildContext context, CvWizardState state) {
    final cubit = context.read<CvWizardCubit>();
    switch (state.step) {
      case CvWizardStep.workExperience:
        cubit.goToStep(CvWizardStep.personalInfo);
      case CvWizardStep.education:
        cubit.goToStep(CvWizardStep.workExperience);
      case CvWizardStep.skills:
        cubit.goToStep(CvWizardStep.education);
      case CvWizardStep.atsResult:
        cubit.goToStep(CvWizardStep.skills);
      case CvWizardStep.personalInfo:
        break;
    }
  }

  Widget _buildCurrentStep(BuildContext context, CvWizardState state) {
    return switch (state.step) {
      CvWizardStep.personalInfo => PersonalInfoStep(
        initial: state.cv.personalInfo,
      ),
      CvWizardStep.workExperience => const WorkExperienceStep(),
      CvWizardStep.education => const EducationStep(),
      CvWizardStep.skills => const SkillsStep(),
      CvWizardStep.atsResult => const AtsResultStep(),
    };
  }
}
