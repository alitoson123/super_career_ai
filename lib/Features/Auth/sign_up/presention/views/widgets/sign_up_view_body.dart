import 'package:flutter/gestures.dart';
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

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  final _authService = AuthService();
  final _googleAuthService = GoogleAuthService();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<String?> _askRole(BuildContext context) async {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => const _RoleBottomSheet(),
    );
  }

  Future<void> _onGoogleRegisterPressed() async {
    if (!_googleAuthService.isSupported) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Google sign-in is not supported here.')),
      );
      return;
    }

    final role = await _askRole(context);
    if (role == null || role.trim().isEmpty) return;

    try {
      final idToken = await _googleAuthService.getIdToken();
      if (idToken == null || idToken.isEmpty) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Google sign-in was cancelled.')),
        );
        return;
      }

     // await _authService.googleRegister(idToken: idToken, role: role);

      if (!mounted) return;
      context.push(AppRoutes.accountCreatedScreen);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google sign-in failed: $e')),
      );
    }
  }

  String _deriveUsername({required String email, required String fullName}) {
    final local = email.split('@').first.trim();
    if (local.isNotEmpty) return local;
    final compact = fullName.trim().replaceAll(RegExp(r'\s+'), '_');
    return compact.isEmpty ? 'string' : compact;
  }

  Future<void> _onCreateAccountPressed() async {
    if (_isSubmitting) return;

    final fullName = _name.text.trim();
    final email = _email.text.trim();
    final password = _password.text;

    if (fullName.isEmpty || email.isEmpty || password.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter name, email and password.')),
      );
      return;
    }

    final role = await _askRole(context) ?? 'job_seeker';
    final username = _deriveUsername(email: email, fullName: fullName);

    setState(() => _isSubmitting = true);
    try {
      await _authService.registerUser(
        username: username,
        email: email,
        password: password,
        role: role,
        fullName: fullName,
      );

      if (!mounted) return;
      context.push(AppRoutes.accountCreatedScreen);
    } catch (e) {
      // Backend currently can return 500 after creating the user.
      // If the account was created, login should succeed; treat that as success.
      try {
        await _authService.loginUser(email: email, password: password);
        if (!mounted) return;
        context.push(AppRoutes.accountCreatedScreen);
      } catch (_) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Register failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
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
                  onPressed: _isSubmitting ? null : _onCreateAccountPressed,
                ),
                SizedBox(height: 28.h),
                const OrContinueDivider(),
                SizedBox(height: 22.h),
                SocialAuthRow(
                  onGoogle: _onGoogleRegisterPressed,
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

class _RoleBottomSheet extends StatefulWidget {
  const _RoleBottomSheet();

  @override
  State<_RoleBottomSheet> createState() => _RoleBottomSheetState();
}

class _RoleBottomSheetState extends State<_RoleBottomSheet> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose your role',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 12.h),
              LabeledTextField(
                label: 'Role',
                controller: _controller,
                hint: 'e.g. freelancer',
                fillColor: const Color(0xFFF7FAFC),
                placeholderColor: const Color(0xFF94A3B8),
              ),
              SizedBox(height: 14.h),
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  label: 'Continue',
                  onPressed: () {
                    final role = _controller.text.trim();
                    if (role.isEmpty) return;
                    Navigator.of(context).pop(role);
                  },
                ),
              ),
              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
    );
  }
}
