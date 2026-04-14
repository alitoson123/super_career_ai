import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/Core/constant/app_colors.dart';

class StatItemCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String badgeText;
  final bool isBadgePositive;
  final bool isBadgeNeutral;

  const StatItemCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.badgeText,
    this.isBadgePositive = false,
    this.isBadgeNeutral = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // icon
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlueLight,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(icon, color: AppColors.primaryBlue, size: 20.sp),
              ),
              // badge text
              if (badgeText.isNotEmpty)
                Text(
                  badgeText,
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium?.copyWith(color: _getBadgeColor()),
                ),
            ],
          ),
          SizedBox(height: 16.h),
          // title
          Text(title, style: Theme.of(context).textTheme.bodySmall),
          SizedBox(height: 4.h),
          // value
          Text(value, style: Theme.of(context).textTheme.titleLarge),
        ],
      ),
    );
  }

  // get badge color
  Color _getBadgeColor() {
    if (isBadgePositive) return AppColors.successGreen;
    if (isBadgeNeutral) return AppColors.textSecondary;
    return AppColors.primaryBlue;
  }
}
