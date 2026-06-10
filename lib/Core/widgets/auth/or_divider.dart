import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/Core/theme/app_colors.dart';

class OrContinueDivider extends StatelessWidget {
  const OrContinueDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(color: AppColors.dividerLine, thickness: 1, height: 1),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Text(
            'Or Continue with',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.headingNavy,
            ),
          ),
        ),
        Expanded(
          child: Divider(color: AppColors.dividerLine, thickness: 1, height: 1),
        ),
      ],
    );
  }
}

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: AppColors.black.withValues(alpha: 0.35),
            thickness: 1,
            height: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Text(
            'Or',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.black,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: AppColors.black.withValues(alpha: 0.35),
            thickness: 1,
            height: 1,
          ),
        ),
      ],
    );
  }
}
