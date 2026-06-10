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

class WorkExperienceStep extends StatelessWidget {
  const WorkExperienceStep({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocBuilder<CvWizardCubit, CvWizardState>(
      builder: (context, state) {
        final cubit = context.read<CvWizardCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CvStepProgressBar(
              stepLabel: s.stepWorkExperience,
              stepCounter: s.stepOf(2, 5),
              currentStep: 2,
              totalSteps: 5,
            ),
            SizedBox(height: 16.h),
            Text(
              s.addWorkHistory,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              s.startWithMostRecent,
              style: TextStyle(fontSize: 13.sp, color: AppColors.textSecondary),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: ListView.separated(
                itemCount: state.cv.workExperiences.length,
                separatorBuilder: (_, i) => SizedBox(height: 16.h),
                itemBuilder: (context, index) => _WorkExperienceCard(
                  index: index,
                  experience: state.cv.workExperiences[index],
                  showRemove: state.cv.workExperiences.length > 1,
                  onRemove: () => cubit.removeWorkExperience(index),
                  onChanged: (exp) => cubit.updateWorkExperience(index, exp),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            _AddPositionButton(
              label: s.addAnotherPosition,
              onTap: cubit.addWorkExperience,
            ),
            SizedBox(height: 12.h),
            CvPrimaryButton(
              label: s.nextEducation,
              icon: Icons.arrow_forward,
              onPressed: cubit.saveWorkExperience,
            ),
          ],
        );
      },
    );
  }
}

class _WorkExperienceCard extends StatefulWidget {
  const _WorkExperienceCard({
    required this.index,
    required this.experience,
    required this.showRemove,
    required this.onRemove,
    required this.onChanged,
  });

  final int index;
  final WorkExperienceEntity experience;
  final bool showRemove;
  final VoidCallback onRemove;
  final ValueChanged<WorkExperienceEntity> onChanged;

  @override
  State<_WorkExperienceCard> createState() => _WorkExperienceCardState();
}

class _WorkExperienceCardState extends State<_WorkExperienceCard> {
  late final TextEditingController _jobCtrl;
  late final TextEditingController _companyCtrl;
  late final TextEditingController _startCtrl;
  late final TextEditingController _endCtrl;
  late final TextEditingController _descCtrl;
  late bool _currentJob;

  @override
  void initState() {
    super.initState();
    _jobCtrl = TextEditingController(text: widget.experience.jobTitle);
    _companyCtrl = TextEditingController(text: widget.experience.company);
    _startCtrl = TextEditingController(text: widget.experience.startDate);
    _endCtrl = TextEditingController(text: widget.experience.endDate);
    _descCtrl = TextEditingController(text: widget.experience.description);
    _currentJob = widget.experience.isCurrentJob;
  }

  @override
  void dispose() {
    _jobCtrl.dispose();
    _companyCtrl.dispose();
    _startCtrl.dispose();
    _endCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  void _notify() {
    widget.onChanged(
      WorkExperienceEntity(
        jobTitle: _jobCtrl.text,
        company: _companyCtrl.text,
        startDate: _startCtrl.text,
        endDate: _endCtrl.text,
        isCurrentJob: _currentJob,
        description: _descCtrl.text,
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
          CvTextField(
            label: s.jobTitle,
            hint: s.professionalTitleHint,
            controller: _jobCtrl,
            onChanged: (_) => _notify(),
          ),
          SizedBox(height: 12.h),
          CvTextField(
            label: s.company,
            hint: s.companyHint,
            controller: _companyCtrl,
            onChanged: (_) => _notify(),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: CvTextField(
                  label: s.startDate,
                  hint: 'MM / YYYY',
                  controller: _startCtrl,
                  onChanged: (_) => _notify(),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: CvTextField(
                  label: s.endDate,
                  hint: 'MM / YYYY',
                  controller: _endCtrl,
                  onChanged: (_) => _notify(),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              SizedBox(
                width: 20.r,
                height: 20.r,
                child: Checkbox(
                  value: _currentJob,
                  activeColor: AppColors.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  onChanged: (v) {
                    setState(() => _currentJob = v ?? false);
                    _notify();
                  },
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                s.currentlyWorkHere,
                style: TextStyle(fontSize: 13.sp, color: AppColors.textPrimary),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          CvTextField(
            label: s.description,
            hint: s.workDescriptionHint,
            controller: _descCtrl,
            maxLines: 3,
            onChanged: (_) => _notify(),
          ),
        ],
      ),
    );
  }
}

class _AddPositionButton extends StatelessWidget {
  const _AddPositionButton({required this.label, required this.onTap});

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
          border: Border.all(
            color: AppColors.primaryBlue,
            style: BorderStyle.solid,
          ),
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
