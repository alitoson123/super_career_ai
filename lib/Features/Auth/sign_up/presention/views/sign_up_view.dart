import 'package:flutter/material.dart';
import 'package:super_career_ai/Features/Auth/sign_up/presention/views/widgets/sign_up_view_body.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SignUpViewBody(),
    );
  }
}
