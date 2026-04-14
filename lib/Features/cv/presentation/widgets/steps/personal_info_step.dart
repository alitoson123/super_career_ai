import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/Core/constant/app_colors.dart';
import 'package:super_career_ai/Features/cv/domain/entities/cv_entity.dart';
import 'package:super_career_ai/Features/cv/presentation/cubit/cv_wizard_cubit.dart';
import 'package:super_career_ai/Features/cv/presentation/widgets/cv_buttons.dart';
import 'package:super_career_ai/Features/cv/presentation/widgets/cv_step_progress_bar.dart';
import 'package:super_career_ai/Features/cv/presentation/widgets/cv_text_field.dart';
import 'package:super_career_ai/generated/l10n.dart';

class PersonalInfoStep extends StatefulWidget {
  const PersonalInfoStep({super.key, required this.initial});

  final PersonalInfoEntity initial;

  @override
  State<PersonalInfoStep> createState() => _PersonalInfoStepState();
}

class _PersonalInfoStepState extends State<PersonalInfoStep> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _titleCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _locationCtrl;
  late final TextEditingController _summaryCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.initial.fullName);
    _titleCtrl =
        TextEditingController(text: widget.initial.professionalTitle);
    _emailCtrl = TextEditingController(text: widget.initial.email);
    _phoneCtrl = TextEditingController(text: widget.initial.phone);
    _locationCtrl = TextEditingController(text: widget.initial.location);
    _summaryCtrl = TextEditingController(text: widget.initial.summary);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _titleCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _locationCtrl.dispose();
    _summaryCtrl.dispose();
    super.dispose();
  }

  void _onNext() {
    context.read<CvWizardCubit>().savePersonalInfo(
      PersonalInfoEntity(
        fullName: _nameCtrl.text.trim(),
        professionalTitle: _titleCtrl.text.trim(),
        email: _emailCtrl.text.trim(),
        phone: _phoneCtrl.text.trim(),
        location: _locationCtrl.text.trim(),
        summary: _summaryCtrl.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CvStepProgressBar(
          stepLabel: s.stepPersonalInformation,
          stepCounter: s.stepOf(1, 5),
          currentStep: 1,
          totalSteps: 5,
        ),
        SizedBox(height: 24.h),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CvTextField(
                  label: s.fullName,
                  hint: s.fullNameHint,
                  controller: _nameCtrl,
                ),
                SizedBox(height: 16.h),
                CvTextField(
                  label: s.professionalTitle,
                  hint: s.professionalTitleHint,
                  controller: _titleCtrl,
                ),
                SizedBox(height: 16.h),
                CvTextField(
                  label: s.emailAddress,
                  hint: s.emailAddressHint,
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16.h),
                CvTextField(
                  label: s.phoneNumber,
                  hint: s.phoneNumberHint,
                  controller: _phoneCtrl,
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 16.h),
                CvTextField(
                  label: s.location,
                  hint: s.locationHint,
                  controller: _locationCtrl,
                  suffix: Icon(
                    Icons.location_on_outlined,
                    color: AppColors.textSecondary,
                    size: 18.sp,
                  ),
                ),
                SizedBox(height: 16.h),
                _SummaryField(
                  label: s.professionalSummary,
                  hint: s.professionalSummaryHint,
                  aiLabel: s.aiSuggestion,
                  controller: _summaryCtrl,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),
        CvPrimaryButton(
          label: s.nextStep,
          icon: Icons.arrow_forward,
          onPressed: _onNext,
        ),
      ],
    );
  }
}

class _SummaryField extends StatelessWidget {
  const _SummaryField({
    required this.label,
    required this.hint,
    required this.aiLabel,
    required this.controller,
  });

  final String label;
  final String hint;
  final String aiLabel;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: AppColors.primaryBlueLight,
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.auto_awesome,
                      size: 12.sp, color: AppColors.primaryBlue),
                  SizedBox(width: 4.w),
                  Text(
                    aiLabel,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        TextFormField(
          controller: controller,
          maxLines: 4,
          style: TextStyle(fontSize: 14.sp, color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 13.sp,
              color: AppColors.textSecondary,
            ),
            filled: true,
            fillColor: AppColors.background,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: 12.h,
            ),
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
        ),
      ],
    );
  }
}
