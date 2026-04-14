import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:super_career_ai/Core/navigator/app_routes.dart';
import 'package:super_career_ai/Core/theme/app_colors.dart';
import 'package:super_career_ai/Core/widgets/auth/labeled_text_field.dart';
import 'package:super_career_ai/Core/widgets/auth/primary_button.dart';

class ForgetPasswordViewBody extends StatefulWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  State<ForgetPasswordViewBody> createState() => _ForgetPasswordViewBodyState();
}

class _ForgetPasswordViewBodyState extends State<ForgetPasswordViewBody> {
  final _email = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w, top: 4.h),
          child: IconButton(
            onPressed: () => context.pop(),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20.sp,
              color: AppColors.headingNavy,
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 24.h),
                Center(
                  child: Image.asset(
                    'assests/images/rafiki.png',
                    width: 0.88.sw,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 28.h),
                LabeledTextField(
                  label: 'Email',
                  controller: _email,
                  hint: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  fillColor: const Color(0xFFF8F9FB),
                  placeholderColor: const Color(0xFF9CA3AF),
                ),
                SizedBox(height: 24.h),
                PrimaryButton(
                  label: 'Send Code',
                  onPressed: () {
                    context.push(
                      AppRoutes.otpVerificationScreen,
                      extra: _email.text.trim().isEmpty
                          ? 'your email@gmail.com'
                          : _email.text.trim(),
                    );
                  },
                ),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
