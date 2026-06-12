import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/Features/jobs/Domain/entities/jobs_entity.dart';
import 'package:super_career_ai/Features/jobs/presentation/view_model/job_cubit.dart/job_cubit.dart';
import 'package:super_career_ai/Features/root/presentation/view_model/navigation_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_career_ai/Features/jobs/presentation/widgets/job_top_match_card.dart';
import 'package:super_career_ai/generated/l10n.dart';

class RecentJobMatches extends StatelessWidget {
  const RecentJobMatches({super.key, required this.jobEntity});
  final List<JobEntity> jobEntity;
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
                Icon(
                  Icons.auto_awesome,
                  color: Theme.of(context).primaryColor,
                  size: 24.sp,
                ),
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
                context.read<NavigationCubit>().changeIndex(1);
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
                  Icon(
                    Icons.arrow_forward,
                    size: 16.sp,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        //job match cards
        if (jobEntity.isNotEmpty) ...[
          JobTopMatchCard(job: jobEntity[0]),
          if (jobEntity.length > 1) JobTopMatchCard(job: jobEntity[1]),
        ] else
          Column(
            children: [
              Center(
                child: Text(
                  S.of(context).noJobMatchesFound,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // retry
                  context.read<JobCubit>().fetchJobMatches();
                },
                child: Text('retry'),
              ),
            ],
          ),
      ],
    );
  }
}
