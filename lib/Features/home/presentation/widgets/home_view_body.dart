import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/Features/Projects/presentation/view_model/project_cubit.dart/project_cubit.dart';
import 'package:super_career_ai/Features/Projects/presentation/view_model/project_cubit.dart/project_cubit_states.dart';
import 'package:super_career_ai/Features/jobs/presentation/view_model/job_cubit.dart/job_cubit.dart';
import 'package:super_career_ai/Features/jobs/presentation/view_model/job_cubit.dart/job_cubit_states.dart';
import 'welcome_section.dart';
import 'stats_grid.dart';
import 'recent_job_matches.dart';
import 'recent_project_matches.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({
    super.key,
    required this.jobState,
    required this.projectState,
  });
  final JobCubitStates jobState;
  final ProjectCubitStates projectState;
  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  Widget build(BuildContext context) {

    final jobState = widget.jobState;
    final projectState = widget.projectState;

    if (jobState is JobFetchLoading || projectState is ProjectFetchLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (jobState is JobFetchFailure ||
        projectState is ProjectFetchFailure) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Error: ${jobState is JobFetchFailure
                  ? jobState.errorMessage
                  : projectState is ProjectFetchFailure
                  ? projectState.errorMessage
                  : 'unknown error'}',

              style: TextStyle(color: Colors.red, fontSize: 20.sp),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // retry
              context.read<JobCubit>().fetchJobMatches();
              context.read<ProjectCubit>().fetchProjectMatches();
            },
            child: Text('retry'),
          ),
        ],
      );
    } else {
      final jobSuccess = jobState as JobFetchSuccess;
      final projectSuccess = projectState as ProjectFetchSuccess;
      return RefreshIndicator(
        onRefresh: () async {
          await context.read<JobCubit>().fetchJobMatches();
          if (!mounted) return;
          // ignore: use_build_context_synchronously
          await context.read<ProjectCubit>().fetchProjectMatches();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // welcome section
                WelcomeSection(
                  newMatchesCount:
                      jobSuccess.jobs.length + projectSuccess.projects.length,
                ),
                SizedBox(height: 18.h),
                // stats grid
                StatsGrid(
                  jobMatchesCount: jobSuccess.jobs.length,
                  projectMatchesCount: projectSuccess.projects.length,
                ),
                SizedBox(height: 20.h),
                // recent job matches
                RecentJobMatches(jobEntity: jobSuccess.jobs),
                SizedBox(height: 32.h),
                // recent project matches
                RecentProjectMatches(projectEntity: projectSuccess.projects),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      );
    }
  }
}
