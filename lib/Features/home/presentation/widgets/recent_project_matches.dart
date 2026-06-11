import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/Core/constant/app_colors.dart';
import 'package:super_career_ai/Features/Projects/Domain/entities/project_entity.dart';
import 'package:super_career_ai/Features/Projects/presentation/widgets/project_top_match_card.dart';
import 'package:super_career_ai/Features/root/presentation/view_model/navigation_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_career_ai/generated/l10n.dart';

class RecentProjectMatches extends StatelessWidget {
  const RecentProjectMatches({super.key, required this.projectEntity});
  final List<ProjectEntity> projectEntity;

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
                context.read<NavigationCubit>().changeIndex(2);
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
        if (projectEntity.isNotEmpty) ...[
          PtojectTopMatchCard(project: projectEntity[0]),
          if (projectEntity.length > 1)
            PtojectTopMatchCard(project: projectEntity[1]),
        ] else
          Center(
            child: Text(
              S.of(context).noJobMatchesFound,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
      ],
    );
  }
}
