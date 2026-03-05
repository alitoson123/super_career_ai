import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:super_career_ai/Core/navigator/app_routes.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    animation = Tween<double>(begin: 0, end: 1).animate(controller);
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        context.go(AppRoutes.onBoardingScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    controller.forward();
    return FadeTransition(
      opacity: animation,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Image.asset('assests/images/logo2.png')],
      ),
    );
  }
}
