import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/Core/constant/app_colors.dart';
import 'package:super_career_ai/Features/jobs/Domain/entities/jobs_entity.dart';
import 'package:super_career_ai/Features/jobs/presentation/view_model/job_cubit.dart/job_cubit.dart';
import 'package:super_career_ai/generated/l10n.dart';
import 'job_top_match_card.dart';

class JopsMatchesViewBody extends StatefulWidget {
  const JopsMatchesViewBody({super.key, required this.jobs});

  final List<JobEntity> jobs;

  @override
  State<JopsMatchesViewBody> createState() => _JopsMatchesViewBodyState();
}

class _JopsMatchesViewBodyState extends State<JopsMatchesViewBody> {

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return RefreshIndicator(
      onRefresh: () async {
        await context.read<JobCubit>().fetchJobMatches();
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              if (widget.jobs.isNotEmpty) ...[
                // List
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.jobs.length,
                  itemBuilder: (context, index) {
                    final job = widget.jobs[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: JobTopMatchCard(job: job),
                    );
                  },
                ),
              ] else
                Column(
                  children: [
                    Center(
                      child: Text(
                        s.noJobMatchesFound,
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
          ),
        ),
      ),
    );
  }
}
