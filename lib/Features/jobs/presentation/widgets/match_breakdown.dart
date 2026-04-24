import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/Core/constant/app_colors.dart';
import 'package:super_career_ai/generated/l10n.dart';

class MatchBreakdown extends StatelessWidget {
  const MatchBreakdown({
    super.key,
    required this.matchBreakdownState,
    required this.progressValue,
  });

  final String matchBreakdownState;
  final double progressValue;

  @override
  Widget build(BuildContext context) {
    Color getBreakdownColor() {
      if (matchBreakdownState == S.of(context).excellent ||
          matchBreakdownState == 'Excellent')
        return AppColors.secondaryGreen;

      if (matchBreakdownState == S.of(context).good ||
          matchBreakdownState == 'Good')
        return AppColors.primaryBlue;

      if (matchBreakdownState == S.of(context).moderate ||
          matchBreakdownState == 'Moderate')
        return AppColors.yellow;

      return AppColors.primaryBlue;
    }

    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // match breakdown title and state
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).matchBreakdown,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12.sp,
                ),
              ),
              Text(
                matchBreakdownState,
                style: TextStyle(
                  color: getBreakdownColor(),
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          // progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: progressValue,
              backgroundColor: AppColors.border,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryBlue),
              minHeight: 6.h,
            ),
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}
