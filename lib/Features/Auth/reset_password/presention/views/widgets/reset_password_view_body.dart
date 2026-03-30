import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:super_career_ai/Core/navigator/app_routes.dart';
import 'package:super_career_ai/Core/theme/app_colors.dart';
import 'package:super_career_ai/Core/widgets/auth/password_labeled_field.dart';
import 'package:super_career_ai/Core/widgets/auth/primary_button.dart';

class ResetPasswordViewBody extends StatefulWidget {
  const ResetPasswordViewBody({super.key});

  @override
  State<ResetPasswordViewBody> createState() => _ResetPasswordViewBodyState();
}

class _ResetPasswordViewBodyState extends State<ResetPasswordViewBody> {
  final _newPass = TextEditingController();
  final _confirmPass = TextEditingController();

  @override
  void dispose() {
    _newPass.dispose();
    _confirmPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),
            Center(
              child: Image.asset(
                'assests/images/image 101 (2).png',
                width: 0.92.sw,
                height: 220.h,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 20.h),
            PasswordLabeledField(
              label: 'New Password',
              controller: _newPass,
              hint: 'Enter new password',
              placeholderColor: AppColors.placeholder,
            ),
            SizedBox(height: 18.h),
            PasswordLabeledField(
              label: 'Confirm Password',
              controller: _confirmPass,
              hint: 'Confirm new password',
              placeholderColor: AppColors.placeholder,
            ),
            SizedBox(height: 28.h),
            PrimaryButton(
              label: 'Reset Password',
              onPressed: () => context.push(AppRoutes.passwordChangedScreen),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
