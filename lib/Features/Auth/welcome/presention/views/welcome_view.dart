import 'package:flutter/material.dart';
import 'package:super_career_ai/Features/Auth/welcome/presention/views/widgets/welcome_view_body.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: WelcomeViewBody(),
    );
  }
}
