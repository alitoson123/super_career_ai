import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:super_career_ai/Core/constant/app_colors.dart';
import 'package:super_career_ai/Core/navigator/app_routes.dart';
import 'package:super_career_ai/generated/l10n.dart';
import 'project_match_card.dart';

class RecentProjectMatches extends StatelessWidget {
  const RecentProjectMatches({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 4.w,
          runSpacing: 4.h,
          children: [
            // title and icon
            Row(
              children: [

                Icon(
                  Icons.dashboard_customize_outlined,
                  color: AppColors.primaryBlue,
                  size: 24.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  S.of(context).recentProjectMatches,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontSize: 20.sp),
                ),
              ],
            ),
            // view all button
            TextButton(
              onPressed: () {
                context.push(AppRoutes.projectMatchesScreen);
              },
              child: Row(
                children: [
                  Text(
                    S.of(context).viewAll,
                    style: TextStyle(
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    Icons.arrow_forward,
                    size: 16.sp,
                    color: AppColors.primaryBlue,
                  ),
                ],
              ),
            ),
          ],
        ),
        // project match cards
        SizedBox(height: 10.h),
        const ProjectMatchCard(
          title: 'Senior UI Designer',
          subtitle: 'Skyline Tech • Full-time',
          priceRange: '\$85k - \$120k',
          matchPercentage: '98% Match',
        ),
        const ProjectMatchCard(
          title: 'Mobile Developer',
          subtitle: 'Pixel Labs • Project',
          priceRange: '\$50 - \$80/hr',
          matchPercentage: '92% Match',
        ),
      ],
    );
  }
}
