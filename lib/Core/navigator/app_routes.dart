import 'package:go_router/go_router.dart';
import 'package:super_career_ai/Features/onboarding/presention/views/onboarding_view.dart';
import 'package:super_career_ai/Features/splash/presention/views/splash_view.dart';

class AppRoutes {
  static String spalshScreen = '/';
  static String onBoardingScreen = '/onBoarding';
  static const String signInScreen = '/signIn';
  static const String signUpScreen = '/signUp';
  static const String forgetPasswordScreen = '/forgetPassword';

  static final route = GoRouter(
    routes: [
      GoRoute(
        path: spalshScreen,
        builder: (context, state) => const SplashView(),
      ),

      GoRoute(
        path: onBoardingScreen,
        builder: (context, state) => const OnBoardingView(),
      ),
    ],
  );
}
