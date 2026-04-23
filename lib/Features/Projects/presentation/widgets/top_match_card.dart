import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/Core/constant/app_colors.dart';
import 'package:super_career_ai/Features/jops/presentation/widgets/match_breakdown.dart';
import 'package:super_career_ai/generated/l10n.dart';

class TopMatchCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String matchPercentage;
  final String matchBreakdownState; 
  final String skillsMatchedText;
  final String extraTagText;
  final double progressValue;

  const TopMatchCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.matchPercentage,
    required this.matchBreakdownState,
    required this.skillsMatchedText,
    required this.extraTagText,
    required this.progressValue,
  });

  @override
  Widget build(BuildContext context) {


    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // logo
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A), 
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Icon(Icons.psychology, color: Colors.greenAccent, size: 24.sp),
                ),
              ),
              SizedBox(width: 12.w),
              // title and subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              // match percentage
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.successGreen.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  matchPercentage,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.successGreen,
                      ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // match breakdown
          MatchBreakdown(matchBreakdownState: matchBreakdownState, progressValue: progressValue, skillsMatchedText: skillsMatchedText, extraTagText: extraTagText),
          SizedBox(height: 16.h),
          // apply button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                S.of(context).viewMatchAndApply,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

