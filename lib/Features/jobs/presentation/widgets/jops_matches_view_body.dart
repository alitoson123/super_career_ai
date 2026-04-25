import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/Core/constant/app_colors.dart';
import 'package:super_career_ai/Features/jobs/Domain/entities/jobs_entity.dart';
import 'package:super_career_ai/generated/l10n.dart';
import 'job_top_match_card.dart';

class JopsMatchesViewBody extends StatefulWidget {
  const JopsMatchesViewBody({super.key, required this.jobs});

  final List<JobEntity> jobs;

  @override
  State<JopsMatchesViewBody> createState() => _JopsMatchesViewBodyState();
}

class _JopsMatchesViewBodyState extends State<JopsMatchesViewBody> {
  int _selectedChipIndex = 0;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final List<String> chips = [s.allMatches, s.highScore];

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Chips
            SizedBox(
              height: 38.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: chips.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedChipIndex == index;
                  return Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedChipIndex = index),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryBlue
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primaryBlue
                                : AppColors.border.withOpacity(0.5),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          chips[index],
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : AppColors.textSecondary,
                            fontSize: 13.sp,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 28.h),

            // Title and count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  s.topMatchesForYou,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    s.foundCount(widget.jobs.length),
                    style: TextStyle(
                      color: AppColors.primaryBlue,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.jobs.length,
              itemBuilder: (context, index) {
                final job = widget.jobs[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: JobTopMatchCard(job: job),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
