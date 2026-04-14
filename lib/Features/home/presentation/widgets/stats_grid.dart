import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/generated/l10n.dart';
import 'stat_item_card.dart';

class StatsGrid extends StatelessWidget {
  const StatsGrid({super.key});

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
          title: S.of(context).matchesToday,
          value: '12',
          badgeText: '+3 ${S.of(context).remote}',
          isBadgePositive: true,
        ),
        StatItemCard(
          icon: Icons.analytics_outlined,
          title: S.of(context).avgMatchScore,
          value: '85%',
          badgeText: '+2%',
          isBadgePositive: true,
        ),
        StatItemCard(
          icon: Icons.description_outlined,
          title: S.of(context).activeProposals,
          value: '8',
          badgeText: S.of(context).remote, // Will adjust
          isBadgeNeutral: true,
        ),
        StatItemCard(
          icon: Icons.visibility_outlined,
          title: S.of(context).profileViews,
          value: '124',
          badgeText: '+15%',
          isBadgePositive: true,
        ),
      ],
    );
  }
}
