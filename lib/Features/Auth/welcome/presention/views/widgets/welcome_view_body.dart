import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:super_career_ai/Core/navigator/app_routes.dart';
import 'package:super_career_ai/Core/services/auth_service/auth_service.dart';
import 'package:super_career_ai/Core/services/auth_service/google_auth_service.dart';
import 'package:super_career_ai/Core/theme/app_colors.dart';
import 'package:super_career_ai/Core/widgets/auth/or_divider.dart';
import 'package:super_career_ai/Core/widgets/auth/social_auth_row.dart';

class WelcomeViewBody extends StatelessWidget {
  const WelcomeViewBody({super.key});

  Future<void> _onGoogleRegisterPressed(BuildContext context) async {
    final googleAuth = GoogleAuthService();
    final authService = AuthService();

    if (!googleAuth.isSupported) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Google sign-in is not supported here.')),
      );
      return;
    }

    try {
      final idToken = await googleAuth.getIdToken();
      if (idToken == null || idToken.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Google sign-in was cancelled.')),
        );
        return;
      }

      //  await authService.googleRegister(idToken: idToken, role: 'job_seeker');
      if (!context.mounted) return;
      context.push(AppRoutes.accountCreatedScreen);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Google sign-in failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12.h),
            Text(
              'Welcome',
              style: TextStyle(
                fontSize: 32.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.black,
                height: 1.1,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Login or sign up to continue',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 28.h),
            Center(
              child: Image.asset(
                'assests/images/illustration_welcome.png',
                fit: BoxFit.contain,
                width: 1.sw,
              ),
            ),
            SizedBox(height: 32.h),
            SizedBox(
              width: double.infinity,
              height: 54.h,
              child: ElevatedButton(
                onPressed: () => context.push(AppRoutes.signUpScreen),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xFF185EF0),
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'SignUp',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(height: 14.h),
            SizedBox(
              width: double.infinity,
              height: 54.h,
              child: OutlinedButton(
                onPressed: () => context.push(AppRoutes.signInScreen),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF185EF0),
                  side: const BorderSide(color: Color(0xFF185EF0), width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'login',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 28.h),
            const OrDivider(),
            SizedBox(height: 22.h),
            SocialAuthRow(
              onGoogle: () => _onGoogleRegisterPressed(context),
              onLinkedIn: () {},
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
