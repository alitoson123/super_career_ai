import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/Core/constant/app_colors.dart';
import 'package:super_career_ai/Features/jobs/presentation/view_model/job_cubit.dart/job_cubit.dart';
import 'package:super_career_ai/Features/jobs/presentation/view_model/job_cubit.dart/job_cubit_states.dart';
import 'package:super_career_ai/generated/l10n.dart';
import '../widgets/cv_history_body.dart';
import '../widgets/jops_matches_view_body.dart';

class JopsMatchesView extends StatefulWidget {
  const JopsMatchesView({super.key});

  @override
  State<JopsMatchesView> createState() => _JopsMatchesViewState();
}

class _JopsMatchesViewState extends State<JopsMatchesView> {
  @override
  void initState() {
    context.read<JobCubit>().fetchJobMatches();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: jopMatchesAppBar(context),
        body: TabBarView(
          children: [
            BlocBuilder<JobCubit, JobCubitStates>(
              builder: (context, state) {
                if (state is JobFetchLoading || state is JobInitial) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is JobFetchFailure) {
                  return Center(child: Text(state.errorMessage));
                } else if (state is JobFetchSuccess) {
                  return JopsMatchesViewBody(jobs: state.jobs);
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
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
        labelStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
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
