import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:super_career_ai/Core/navigator/app_routes.dart';
import 'package:super_career_ai/Core/theme/app_colors.dart';
import 'package:super_career_ai/Core/widgets/auth/auth_scaffold_bar.dart';
import 'package:super_career_ai/Core/widgets/auth/labeled_text_field.dart';
import 'package:super_career_ai/Core/widgets/auth/or_divider.dart';
import 'package:super_career_ai/Core/widgets/auth/password_labeled_field.dart';
import 'package:super_career_ai/Core/widgets/auth/primary_button.dart';
import 'package:super_career_ai/Core/widgets/auth/social_auth_row.dart';

class SignInViewBody extends StatefulWidget {
  const SignInViewBody({super.key});

  @override
  State<SignInViewBody> createState() => _SignInViewBodyState();
}

class _SignInViewBodyState extends State<SignInViewBody> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AuthScaffoldBar(title: 'Super career'),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.h),
                Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.headingNavy,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Log in to your freelance account to continue your journey',
                  style: TextStyle(
                    fontSize: 14.sp,
                    height: 1.45,
                    fontWeight: FontWeight.w500,
                    color: AppColors.bodyMutedBlue,
                  ),
                ),
                SizedBox(height: 24.h),
                LabeledTextField(
                  label: 'Email',
                  controller: _email,
                  hint: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20.h),
                PasswordLabeledField(
                  label: 'Password',
                  controller: _password,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => context.push(AppRoutes.forgetPasswordScreen),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.only(top: 4.h),
                      foregroundColor: AppColors.primaryBlue,
                    ),
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                PrimaryButton(
                  label: 'Login',
                  onPressed: () {},
                ),
                SizedBox(height: 28.h),
                const OrContinueDivider(),
                SizedBox(height: 22.h),
                SocialAuthRow(
                  onGoogle: () {},
                  onLinkedIn: () {},
                ),
                SizedBox(height: 28.h),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
