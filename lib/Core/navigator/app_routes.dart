import 'package:go_router/go_router.dart';
import 'package:super_career_ai/Core/navigator/page_transitions.dart';
import 'package:super_career_ai/Features/Auth/account_created/presention/views/account_created_view.dart';
import 'package:super_career_ai/Features/Auth/forget_password/presention/views/forget_password_view.dart';
import 'package:super_career_ai/Features/Auth/otp_verification/presention/views/otp_verification_view.dart';
import 'package:super_career_ai/Features/Auth/password_changed/presention/views/password_changed_view.dart';
import 'package:super_career_ai/Features/Auth/reset_password/presention/views/reset_password_view.dart';
import 'package:super_career_ai/Features/Auth/sign_in/presention/views/sign_in_view.dart';
import 'package:super_career_ai/Features/Auth/sign_up/presention/views/sign_up_view.dart';
import 'package:super_career_ai/Features/Auth/welcome/presention/views/welcome_view.dart';
import 'package:super_career_ai/Features/onboarding/presention/views/onboarding_view.dart';
import 'package:super_career_ai/Features/splash/presention/views/splash_view.dart';

class AppRoutes {
  static const String splashScreen = '/';
  static const String onBoardingScreen = '/onBoarding';
  static const String welcomeScreen = '/welcome';
  static const String signInScreen = '/signIn';
  static const String signUpScreen = '/signUp';
  static const String forgetPasswordScreen = '/forgetPassword';
  static const String otpVerificationScreen = '/otpVerification';
  static const String resetPasswordScreen = '/resetPassword';
  static const String passwordChangedScreen = '/passwordChanged';
  static const String accountCreatedScreen = '/accountCreated';

  /// Backwards-compatible alias used in older navigation code.
  static String get spalshScreen => splashScreen;

  static final GoRouter route = GoRouter(
    initialLocation: splashScreen,
    routes: [
      GoRoute(
        path: splashScreen,
        pageBuilder: (context, state) => buildFadePage(
          pageKey: state.pageKey,
          child: const SplashView(),
        ),
      ),
      GoRoute(
        path: onBoardingScreen,
        pageBuilder: (context, state) => buildSlideFadePage(
          pageKey: state.pageKey,
          child: const OnBoardingView(),
        ),
      ),
      GoRoute(
        path: welcomeScreen,
        pageBuilder: (context, state) => buildSlideFadePage(
          pageKey: state.pageKey,
          child: const WelcomeView(),
        ),
      ),
      GoRoute(
        path: signInScreen,
        pageBuilder: (context, state) => buildSlideFadePage(
          pageKey: state.pageKey,
          child: const SignInView(),
        ),
      ),
      GoRoute(
        path: signUpScreen,
        pageBuilder: (context, state) => buildSlideFadePage(
          pageKey: state.pageKey,
          child: const SignUpView(),
        ),
      ),
      GoRoute(
        path: forgetPasswordScreen,
        pageBuilder: (context, state) => buildSlideFadePage(
          pageKey: state.pageKey,
          child: const ForgetPasswordView(),
        ),
      ),
      GoRoute(
        path: otpVerificationScreen,
        pageBuilder: (context, state) {
          final email = state.extra is String
              ? state.extra! as String
              : 'your email@gmail.com';
          return buildSlideFadePage(
            pageKey: state.pageKey,
            child: OtpVerificationView(email: email),
          );
        },
      ),
      GoRoute(
        path: resetPasswordScreen,
        pageBuilder: (context, state) => buildSlideFadePage(
          pageKey: state.pageKey,
          child: const ResetPasswordView(),
        ),
      ),
      GoRoute(
        path: passwordChangedScreen,
        pageBuilder: (context, state) => buildSlideFadePage(
          pageKey: state.pageKey,
          child: const PasswordChangedView(),
        ),
      ),
      GoRoute(
        path: accountCreatedScreen,
        pageBuilder: (context, state) => buildSlideFadePage(
          pageKey: state.pageKey,
          child: const AccountCreatedView(),
        ),
      ),
    ],
  );
}
