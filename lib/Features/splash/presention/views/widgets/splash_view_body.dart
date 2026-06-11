import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_career_ai/Core/navigator/app_routes.dart';
import 'package:super_career_ai/Core/services/locator_service/service_locator.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Timer? _navTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
    _navTimer = Timer(const Duration(seconds: 4), () {
      if (mounted) {
        _navigate();
      }
    });
  }

  void _navigate() {
    final prefs = getIt<SharedPreferences>();
    final token = prefs.getString('auth_token');
    if (token != null && token.isNotEmpty) {
      context.go(AppRoutes.rootScreen);
    } else {
      context.go(AppRoutes.onBoardingScreen);
    }
  }

  @override
  void dispose() {
    _navTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Image.asset('assests/images/logo2.png')],
      ),
    );
  }
}
