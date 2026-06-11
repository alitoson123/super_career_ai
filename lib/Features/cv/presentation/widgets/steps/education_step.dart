import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/Core/constant/app_colors.dart';
import 'package:super_career_ai/Features/cv/domain/entities/cv_entity.dart';
import 'package:super_career_ai/Features/cv/presentation/cubit/cv_wizard_cubit.dart';
import 'package:super_career_ai/Features/cv/presentation/cubit/cv_wizard_state.dart';
import 'package:super_career_ai/Features/cv/presentation/widgets/cv_buttons.dart';
import 'package:super_career_ai/Features/cv/presentation/widgets/cv_step_progress_bar.dart';
import 'package:super_career_ai/Features/cv/presentation/widgets/cv_text_field.dart';
import 'package:super_career_ai/generated/l10n.dart';

class EducationStep extends StatelessWidget {
  const EducationStep({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocBuilder<CvWizardCubit, CvWizardState>(
      builder: (context, state) {
        final cubit = context.read<CvWizardCubit>();
        final isAllValid = state.cv.educations.every((e) => e.isValid);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CvStepProgressBar(
              stepLabel: s.stepEducation,
              stepCounter: s.stepOf(3, 5),
              currentStep: 3,
              totalSteps: 5,
            ),
            SizedBox(height: 16.h),
            Text(
              s.addYourEducation,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              s.educationDetailsHint,
              style: TextStyle(fontSize: 13.sp, color: AppColors.textSecondary),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: ListView.separated(
                itemCount: state.cv.educations.length,
                separatorBuilder: (_, i) => SizedBox(height: 16.h),
                itemBuilder: (context, index) => _EducationCard(
                  education: state.cv.educations[index],
                  showRemove: state.cv.educations.length > 1,
                  onRemove: () => cubit.removeEducation(index),
                  onChanged: (edu) => cubit.updateEducation(index, edu),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            _AddEducationButton(
              label: s.addEducation,
              onTap: cubit.addEducation,
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                CvOutlinedButton(
                  label: s.back,
                  onPressed: () => cubit.goToStep(CvWizardStep.workExperience),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: CvPrimaryButton(
                    label: s.saveAndContinue,
                    onPressed: isAllValid ? cubit.saveEducation : () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fill all education fields')),
                      );
                    },
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

class _EducationCard extends StatefulWidget {
  const _EducationCard({
    required this.education,
    required this.showRemove,
    required this.onRemove,
    required this.onChanged,
  });

  final EducationEntity education;
  final bool showRemove;
  final VoidCallback onRemove;
  final ValueChanged<EducationEntity> onChanged;

  @override
  State<_EducationCard> createState() => _EducationCardState();
}

class _EducationCardState extends State<_EducationCard> {
  late final TextEditingController _schoolCtrl;
  late final TextEditingController _degreeCtrl;
  late final TextEditingController _yearCtrl;
  late final TextEditingController _descCtrl;

  @override
  void initState() {
    super.initState();
    _schoolCtrl = TextEditingController(text: widget.education.school);
    _degreeCtrl = TextEditingController(text: widget.education.degree);
    _yearCtrl = TextEditingController(text: widget.education.graduationYear);
    _descCtrl = TextEditingController(text: widget.education.description);
  }

  @override
  void dispose() {
    _schoolCtrl.dispose();
    _degreeCtrl.dispose();
    _yearCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  void _notify() {
    widget.onChanged(
      EducationEntity(
        school: _schoolCtrl.text.trim(),
        degree: _degreeCtrl.text.trim(),
        graduationYear: _yearCtrl.text.trim(),
        description: _descCtrl.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.showRemove)
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: widget.onRemove,
                child: Text(
                  s.remove,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          _FieldWithIcon(
            icon: Icons.school_outlined,
            child: CvTextField(
              label: s.schoolUniversity,
              hint: s.schoolHint,
              controller: _schoolCtrl,
              onChanged: (_) => _notify(),
            ),
          ),
          SizedBox(height: 12.h),
          _FieldWithIcon(
            icon: Icons.workspace_premium_outlined,
            child: CvTextField(
              label: s.degree,
              hint: s.degreeHint,
              controller: _degreeCtrl,
              onChanged: (_) => _notify(),
            ),
          ),
          SizedBox(height: 12.h),
          _FieldWithIcon(
            icon: Icons.calendar_today_outlined,
            child: CvTextField(
              label: s.graduationYear,
              hint: s.graduationYearHint,
              controller: _yearCtrl,
              keyboardType: TextInputType.number,
              onChanged: (_) => _notify(),
            ),
          ),
          SizedBox(height: 12.h),
          CvTextField(
            label: s.descriptionOptional,
            hint: s.educationDescriptionHint,
            controller: _descCtrl,
            maxLines: 3,
            onChanged: (_) => _notify(),
          ),
        ],
      ),
    );
  }
}

class _FieldWithIcon extends StatelessWidget {
  const _FieldWithIcon({required this.icon, required this.child});

  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 28.h, right: 8.w),
          child: Icon(icon, size: 18.sp, color: AppColors.textSecondary),
        ),
        Expanded(child: child),
      ],
    );
  }
}

class _AddEducationButton extends StatelessWidget {
  const _AddEducationButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryBlue),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: AppColors.primaryBlue, size: 18.sp),
            SizedBox(width: 6.w),
            Text(
              label,
              style: TextStyle(
                color: AppColors.primaryBlue,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
