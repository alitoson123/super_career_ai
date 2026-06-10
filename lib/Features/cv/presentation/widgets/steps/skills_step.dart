import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/Core/constant/app_colors.dart';
import 'package:super_career_ai/Features/cv/presentation/cubit/cv_wizard_cubit.dart';
import 'package:super_career_ai/Features/cv/presentation/cubit/cv_wizard_state.dart';
import 'package:super_career_ai/Features/cv/presentation/widgets/cv_buttons.dart';
import 'package:super_career_ai/Features/cv/presentation/widgets/cv_step_progress_bar.dart';
import 'package:super_career_ai/generated/l10n.dart';

/// Predefined skill suggestions shown as quick-add chips.
const List<String> _suggestedSkills = [
  'UI Design',
  'UX Research',
  'Figma',
  'Prototyping',
  'User Flows',
  'Mobile Design',
  'Responsive Design',
  'Product Strategy',
  'A/B Testing',
  'Design Systems',
  'Python',
];

class SkillsStep extends StatefulWidget {
  const SkillsStep({super.key});

  @override
  State<SkillsStep> createState() => _SkillsStepState();
}

class _SkillsStepState extends State<SkillsStep> {
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocBuilder<CvWizardCubit, CvWizardState>(
      builder: (context, state) {
        final cubit = context.read<CvWizardCubit>();
        final selectedSkills = state.cv.skills;

        final recommended = _suggestedSkills
            .where((sk) => !selectedSkills.contains(sk))
            .toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CvStepProgressBar(
              stepLabel: s.stepSkills,
              stepCounter: s.stepOf(4, 5),
              currentStep: 4,
              totalSteps: 5,
            ),
            SizedBox(height: 16.h),
            Text(
              s.whatAreYourTopSkills,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              s.skillsInstruction,
              style: TextStyle(fontSize: 13.sp, color: AppColors.textSecondary),
            ),
            SizedBox(height: 16.h),
            // Search + add row
            Row(
              children: [
                Expanded(
                  child: _SkillSearchField(
                    controller: _searchCtrl,
                    hint: s.search,
                  ),
                ),
                SizedBox(width: 8.w),
                _AddSkillButton(
                  label: s.add,
                  onTap: () {
                    cubit.addSkill(_searchCtrl.text);
                    _searchCtrl.clear();
                  },
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Selected chips
                    if (selectedSkills.isNotEmpty) ...[
                      Text(
                        s.selectedSkills(selectedSkills.length),
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: selectedSkills
                            .map(
                              (sk) => _SelectedSkillChip(
                                label: sk,
                                onRemove: () => cubit.removeSkill(sk),
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(height: 24.h),
                    ],
                    // Recommended
                    if (recommended.isNotEmpty) ...[
                      _RecommendedHeader(label: s.recommendedForYou),
                      SizedBox(height: 4.h),
                      Text(
                        s.recommendedSkillsInstruction,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: recommended
                            .map(
                              (sk) => _RecommendedChip(
                                label: sk,
                                onTap: () => cubit.addSkill(sk),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                CvOutlinedButton(
                  label: s.back,
                  onPressed: () => cubit.goToStep(CvWizardStep.education),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: CvPrimaryButton(
                    label: s.continueBtn,
                    icon: Icons.arrow_forward,
                    isLoading: state.isLoading,
                    onPressed: cubit.submitSkillsAndAnalyze,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _SkillSearchField extends StatelessWidget {
  const _SkillSearchField({required this.controller, required this.hint});

  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(fontSize: 14.sp, color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontSize: 14.sp, color: AppColors.textSecondary),
        filled: true,
        fillColor: AppColors.background,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColors.primaryBlue, width: 1.5),
        ),
      ),
    );
  }
}

class _AddSkillButton extends StatelessWidget {
  const _AddSkillButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.primaryBlue,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _SelectedSkillChip extends StatelessWidget {
  const _SelectedSkillChip({required this.label, required this.onRemove});

  final String label;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.primaryBlueLight,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.primaryBlue.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColors.primaryBlue,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 6.w),
          GestureDetector(
            onTap: onRemove,
            child: Icon(Icons.close, size: 14.sp, color: AppColors.primaryBlue),
          ),
        ],
      ),
    );
  }
}

class _RecommendedChip extends StatelessWidget {
  const _RecommendedChip({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.border),
        ),
        child: Text(
          label,
          style: TextStyle(color: AppColors.textSecondary, fontSize: 13.sp),
        ),
      ),
    );
  }
}

class _RecommendedHeader extends StatelessWidget {
  const _RecommendedHeader({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.auto_awesome, size: 14.sp, color: AppColors.primaryBlue),
        SizedBox(width: 6.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
