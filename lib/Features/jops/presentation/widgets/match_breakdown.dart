import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/Core/constant/app_colors.dart';
import 'package:super_career_ai/generated/l10n.dart';

class MatchBreakdown extends StatelessWidget {
  const MatchBreakdown({
    super.key,
    required this.matchBreakdownState,
    required this.progressValue,
    required this.skillsMatchedText,
    required this.extraTagText,
  });

  final String matchBreakdownState;
  final double progressValue;
  final String skillsMatchedText;
  final String extraTagText;

  @override
  Widget build(BuildContext context) {
    Color getBreakdownColor() {
      if (matchBreakdownState == S.of(context).excellent ||
          matchBreakdownState == 'Excellent')
        return AppColors.primaryBlue;
      if (matchBreakdownState == S.of(context).moderate ||
          matchBreakdownState == 'Moderate')
        return AppColors.primaryBlue;
      return AppColors
          .primaryBlue; // Based on UI all are blue, but percentage is different
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
          // skills matched text and extra tag
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(4.r),
                  border: Border.all(color: AppColors.border),
                ),
                // skills matched text
                child: Text(
                  skillsMatchedText,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 10.sp,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              // extra tag
              if (extraTagText.isNotEmpty)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(4.r),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Text(
                    extraTagText,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
