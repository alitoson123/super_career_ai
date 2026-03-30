import 'package:flutter/gestures.dart';
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

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AuthScaffoldBar(title: 'Sign Up'),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.h),
                Text(
                  'Join Super career',
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1A202C),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Connect with top clients and grow your career. Create your professional account today.',
                  style: TextStyle(
                    fontSize: 14.sp,
                    height: 1.45,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF4A5568),
                  ),
                ),
                SizedBox(height: 28.h),
                LabeledTextField(
                  label: 'Full Name',
                  controller: _name,
                  hint: 'e.g. Alex Johnson',
                  fillColor: const Color(0xFFF7FAFC),
                  placeholderColor: const Color(0xFF94A3B8),
                ),
                SizedBox(height: 18.h),
                LabeledTextField(
                  label: 'Email Address',
                  controller: _email,
                  hint: 'alex@example.com',
                  keyboardType: TextInputType.emailAddress,
                  fillColor: const Color(0xFFF7FAFC),
                  placeholderColor: const Color(0xFF94A3B8),
                ),
                SizedBox(height: 18.h),
                PasswordLabeledField(
                  label: 'Password',
                  controller: _password,
                  hint: 'Enter your password',
                  placeholderColor: const Color(0xFF94A3B8),
                  fillColor: const Color(0xFFF7FAFC),
                ),
                SizedBox(height: 28.h),
                PrimaryButton(
                  label: 'Create Account',
                  onPressed: () => context.push(AppRoutes.accountCreatedScreen),
                ),
                SizedBox(height: 28.h),
                const OrContinueDivider(),
                SizedBox(height: 22.h),
                SocialAuthRow(
                  onGoogle: () {},
                  onLinkedIn: () {},
                ),
                SizedBox(height: 24.h),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        const TextSpan(text: 'Already have an accouunt? '),
                        TextSpan(
                          text: 'Log in',
                          style: TextStyle(
                            color: AppColors.primaryBlue,
                            fontWeight: FontWeight.w700,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => context.push(AppRoutes.signInScreen),
                        ),
                      ],
                    ),
                  ),
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
