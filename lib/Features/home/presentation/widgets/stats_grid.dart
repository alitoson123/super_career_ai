import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/generated/l10n.dart';
import 'stat_item_card.dart';

class StatsGrid extends StatelessWidget {
  const StatsGrid({
    super.key,
    required this.jobMatchesCount,
    required this.projectMatchesCount,
  });

  final int jobMatchesCount;
  final int projectMatchesCount;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16.h,
      crossAxisSpacing: 16.w,
      childAspectRatio: 1.2,
      children: [
        // matches today cards
        StatItemCard(
          icon: Icons.auto_awesome,
          title: S.of(context).matchesInJobsToday,
          value: jobMatchesCount.toString(),
        ),
        StatItemCard(
          icon: Icons.auto_awesome,
          title: S.of(context).matchesInProjectsToday,
          value: projectMatchesCount.toString(),
        ),
      ],
    );
  }
}
