import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/generated/l10n.dart';
import 'welcome_section.dart';
import 'stats_grid.dart';
import 'recent_job_matches.dart';
import 'recent_project_matches.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // welcome section
            WelcomeSection(
              userName: s.userName,
              newMatchesCount: 3,
            ),
            SizedBox(height: 24.h),
            // stats grid
            const StatsGrid(),
            SizedBox(height: 32.h),
            // recent job matches
            const RecentJobMatches(),
            SizedBox(height: 32.h),
            // recent project matches
            const RecentProjectMatches(),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
