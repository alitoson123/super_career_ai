import 'package:flutter/material.dart';
import 'package:super_career_ai/Features/Auth/reset_password/presention/views/widgets/reset_password_view_body.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: ResetPasswordViewBody(),
    );
  }
}
