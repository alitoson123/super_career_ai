import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:super_career_ai/Core/navigator/app_routes.dart';

import 'package:super_career_ai/generated/l10n.dart';
import 'job_match_card.dart';

class RecentJobMatches extends StatelessWidget {
  const RecentJobMatches({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // title and icon
            Row(
              children: [
                Icon(Icons.auto_awesome, color: Theme.of(context).primaryColor, size: 24.sp),
                SizedBox(width: 8.w),
                Text(
                  S.of(context).recentJobMatches,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            // view all button
            TextButton(
              onPressed: () {
                context.push(AppRoutes.jobMatchesScreen);
              },
              child: Row(
                children: [
                  Text(
                    S.of(context).viewAll,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(Icons.arrow_forward, size: 16.sp, color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        // job match cards
        const JobMatchCard(
          title: 'Design a Mobile App UI for Fitness',
          matchPercentage: '91% Match',
          tags: ['Figma', 'Tailwind', 'Full-time'],
        ),
        const JobMatchCard(
          title: 'Build a Task Management Web',
          matchPercentage: '91% Match',
          tags: ['React', 'TypeScript', 'Contract'],
        ),
      ],
    );
  }
}
