import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/Core/constant/app_colors.dart';
import 'package:super_career_ai/Core/theme/app_text_styles.dart';
import 'package:super_career_ai/Features/jops/presentation/widgets/job_filters.dart';
import 'package:super_career_ai/generated/l10n.dart';
import 'top_match_card.dart';

class JopsMatchesViewBody extends StatefulWidget {
  const JopsMatchesViewBody({super.key});

  @override
  State<JopsMatchesViewBody> createState() => _JopsMatchesViewBodyState();
}

class _JopsMatchesViewBodyState extends State<JopsMatchesViewBody> {
  int _selectedChipIndex = 0;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final List<String> chips = [
      s.allMatches,
      s.highScore,
      s.remote,
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.background,
                hintText: S.of(context).searchMatchedJobs,
                hintStyle: AppTextStyles.bodyMedium,
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 8.w, right: 8.w),
                  child: Icon(
                    Icons.search,
                    color: AppColors.unselectedIcon,
                    size: 20.sp,
                  ),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide:
                      BorderSide(color: AppColors.primaryBlue, width: 1.w),
                ),
              ),
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textPrimary),
            ),
            SizedBox(height: 16.h),

            // Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  chips.length,
                  (index) => Padding(
                    padding: EdgeInsets.only(
                      right: index == chips.length - 1 ? 0 : 8.w,
                    ),
                    child: JobFilters(
                      label: chips[index],
                      isSelected: _selectedChipIndex == index,
                      onTap: () {
                        setState(() {
                          _selectedChipIndex = index;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Title and count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).topMatchesForYou,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  S.of(context).foundCount(12),
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.primaryBlue,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // List
            TopMatchCard(
              title: 'Senior Product Designer',
              subtitle: 'DesignLabs • San Francisco (Remote)',
              matchPercentage: '98% Match',
              matchBreakdownState: S.of(context).excellent,
              progressValue: 0.9,
              skillsMatchedText: S.of(context).skillsMatched(8, 10),
              extraTagText: S.of(context).preferredTimezone,
            ),
            TopMatchCard(
              title: 'Full Stack Developer',
              subtitle: 'FinTech Solutions • New York (Hybrid)',
              matchPercentage: '85% Match',
              matchBreakdownState: S.of(context).good,
              progressValue: 0.75,
              skillsMatchedText: S.of(context).skillsMatched(6, 10),
              extraTagText: S.of(context).budgetRangeMatch,
            ),
            TopMatchCard(
              title: 'Growth Marketer',
              subtitle: 'StreamLine Studio • London (Remote)',
              matchPercentage: '72% Match',
              matchBreakdownState: S.of(context).moderate,
              progressValue: 0.5,
              skillsMatchedText: S.of(context).skillsMatched(5, 10),
              extraTagText: '',
            ),
          ],
        ),
      ),
    );
  }


}
