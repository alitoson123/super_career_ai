import 'package:flutter/material.dart';
import 'package:super_career_ai/Features/Auth/account_created/presention/views/widgets/account_created_view_body.dart';

class AccountCreatedView extends StatelessWidget {
  const AccountCreatedView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: AccountCreatedViewBody(),
    );
  }
}
