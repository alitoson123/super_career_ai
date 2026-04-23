import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:super_career_ai/Core/navigator/app_routes.dart';
import 'package:super_career_ai/Core/services/auth_service/auth_service.dart';
import 'package:super_career_ai/Core/services/auth_service/google_auth_service.dart';
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

  final _authService = AuthService();
  final _googleAuthService = GoogleAuthService();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _onLoginPressed() async {
    if (_isSubmitting) return;

    final email = _email.text.trim();
    final password = _password.text;

    if (email.isEmpty || password.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password.')),
      );
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      await _authService.loginUser(email: email, password: password);
      if (!mounted) return;
      context.go(AppRoutes.rootScreen);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  Future<void> _onGoogleRegisterPressed() async {
    if (!_googleAuthService.isSupported) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Google sign-in is not supported here.')),
      );
      return;
    }

    try {
      final idToken = await _googleAuthService.getIdToken();
      if (idToken == null || idToken.isEmpty) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Google sign-in was cancelled.')),
        );
        return;
      }

      await _authService.googleLogin(idToken: idToken, role: 'job_seeker');

      if (!mounted) return;
      context.go(AppRoutes.rootScreen);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google sign-in failed: $e')),
      );
    }
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
                  onPressed: _isSubmitting ? null : _onLoginPressed,
                ),
                SizedBox(height: 28.h),
                const OrContinueDivider(),
                SizedBox(height: 22.h),
                SocialAuthRow(
                  onGoogle: _onGoogleRegisterPressed,
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
