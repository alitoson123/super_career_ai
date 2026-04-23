import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/Core/constant/app_colors.dart';
import 'package:super_career_ai/generated/l10n.dart';
import '../widgets/jops_matches_view_body.dart';

class JopsMatchesView extends StatelessWidget {
  const JopsMatchesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: jopMatchesAppBar(context),
      body: const JopsMatchesViewBody(),
    );
  }

  AppBar jopMatchesAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      title: Text(
        S.of(context).jopMatchesTitle,
        style: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 18.sp,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications_none, color: AppColors.textPrimary, size: 24.sp),
          onPressed: () {},
        ),
      ],
    );
  }
}
