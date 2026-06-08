import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/Core/constant/app_colors.dart';
import 'package:super_career_ai/Features/Projects/presentation/view_model/project_cubit.dart/project_cubit.dart';
import 'package:super_career_ai/Features/Projects/presentation/view_model/project_cubit.dart/project_cubit_states.dart';
import 'package:super_career_ai/generated/l10n.dart';
import '../widgets/project_matches_view_body.dart';
import '../widgets/proposal_history_body.dart';

class ProjectMatchesView extends StatefulWidget {
  const ProjectMatchesView({super.key, required this.projectState});
  final ProjectCubitStates projectState;

  @override
  State<ProjectMatchesView> createState() => _ProjectMatchesViewState();
}

class _ProjectMatchesViewState extends State<ProjectMatchesView> {
  @override
  Widget build(BuildContext context) {
    final projectState = widget.projectState;
    final isLoading = projectState is ProjectFetchLoading;
    final isFailure = projectState is ProjectFetchFailure;
    final isSuccess = projectState is ProjectFetchSuccess;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: projectMatchesAppBar(context),
        body: TabBarView(
          children: [
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : isFailure
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(projectState.errorMessage),
                      // retry button
                      ElevatedButton(
                        onPressed: () {
                          // retry
                          context.read<ProjectCubit>().fetchProjectMatches();
                        },
                        child: Text('retry'),
                      ),
                    ],
                  )
                : isSuccess
                ? ProjectMatchesViewBody(projects: projectState.projects)
                : const SizedBox.shrink(),
            const ProposalHistoryBody(),
          ],
        ),
      ),
    );
  }

  AppBar projectMatchesAppBar(BuildContext context) {
    final s = S.of(context);
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      title: Text(
        s.projectMatchesTitle,
        style: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 18.sp,
        ),
      ),
      /*    actions: [
        IconButton(
          icon: Icon(
            Icons.notifications_none,
            color: AppColors.textPrimary,
            size: 24.sp,
          ),
          onPressed: () {},
        ),
      ],*/
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
          Tab(text: s.projectMatches),
          Tab(text: s.history),
        ],
      ),
    );
  }
}
