import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/Core/constant/app_colors.dart';
import 'package:super_career_ai/Features/jobs/presentation/view_model/job_cubit.dart/job_cubit_states.dart';
import 'package:super_career_ai/generated/l10n.dart';
import '../widgets/cv_history_body.dart';
import '../widgets/jops_matches_view_body.dart';

class JopsMatchesView extends StatefulWidget {
  const JopsMatchesView({super.key, required this.jobState});
  final JobCubitStates jobState;
  @override
  State<JopsMatchesView> createState() => _JopsMatchesViewState();
}

class _JopsMatchesViewState extends State<JopsMatchesView> {
  @override
  Widget build(BuildContext context) {
    final jobState = widget.jobState;
    final isLoading = jobState is JobFetchLoading;
    final isFailure = jobState is JobFetchFailure;
    final isSuccess = jobState is JobFetchSuccess;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: jopMatchesAppBar(context),
        body: TabBarView(
          children: [
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : isFailure
                ? Center(child: Text(jobState.errorMessage))
                : isSuccess
                ? JopsMatchesViewBody(jobs: jobState.jobs)
                : const SizedBox.shrink(),

            const CVHistoryBody(),
          ],
        ),
      ),
    );
  }

  AppBar jopMatchesAppBar(BuildContext context) {
    final s = S.of(context);
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      title: Text(
        s.jopMatchesTitle,
        style: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 18.sp,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.notifications_none,
            color: AppColors.textPrimary,
            size: 24.sp,
          ),
          onPressed: () {},
        ),
      ],
      bottom: TabBar(
        labelColor: AppColors.primaryBlue,
        unselectedLabelColor: AppColors.unselectedIcon,
        indicatorColor: AppColors.primaryBlue,
        indicatorWeight: 3.h,
        labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.normal,
        ),
        tabs: [
          Tab(text: s.jobMatches),
          Tab(text: s.history),
        ],
      ),
    );
  }
}
