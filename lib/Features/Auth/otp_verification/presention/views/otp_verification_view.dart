import 'package:flutter/material.dart';
import 'package:super_career_ai/Features/Auth/otp_verification/presention/views/widgets/otp_verification_view_body.dart';

class OtpVerificationView extends StatelessWidget {
  const OtpVerificationView({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: OtpVerificationViewBody(email: email),
    );
  }
}
