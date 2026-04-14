import 'package:go_router/go_router.dart';
import 'package:super_career_ai/Features/jops/presentation/views/jops_matches_view.dart';
import 'package:super_career_ai/Features/root/presentation/views/root_view.dart';
import 'package:super_career_ai/Features/home/presentation/views/home_view.dart';
import 'package:super_career_ai/Features/onboarding/presention/views/onboarding_view.dart';
import 'package:super_career_ai/Features/splash/presention/views/splash_view.dart';
import 'package:super_career_ai/Features/notifications/presentation/views/notifications_view.dart';

class AppRoutes {
  static String spalshScreen = '/';
  static String onBoardingScreen = '/onBoarding';
  static const String signInScreen = '/signIn';
  static const String signUpScreen = '/signUp';
  static const String forgetPasswordScreen = '/forgetPassword';
  static const String homeScreen = '/home';
  static const String rootScreen = '/root';
  static const String notificationsScreen = '/notifications';
  static const String jobMatchesScreen = '/jobMatches';
  static const String projectMatchesScreen = '/projectMatches';

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
      GoRoute(path: rootScreen, builder: (context, state) => const RootView()),
      GoRoute(path: homeScreen, builder: (context, state) => const HomeView()),
      GoRoute(
        path: notificationsScreen,
        builder: (context, state) => const NotificationsView(),
      ),
      GoRoute(
        path: jobMatchesScreen,
        builder: (context, state) => const JopsMatchesView(),
      ),
      GoRoute(
        path: projectMatchesScreen,
        builder: (context, state) => const JopsMatchesView(),
      ),
    ],
  );
}
