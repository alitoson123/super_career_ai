import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/Core/constant/app_colors.dart';
import 'package:super_career_ai/Core/services/locator_service/service_locator.dart';
import 'package:super_career_ai/Features/Projects/Data/repo_impl/project_repo_impl.dart';
import 'package:super_career_ai/Features/Projects/presentation/view_model/project_cubit.dart/project_cubit.dart';
import 'package:super_career_ai/Features/Projects/presentation/view_model/project_cubit.dart/project_cubit_states.dart';
import 'package:super_career_ai/Features/Projects/presentation/views/project_matches_view.dart';
import 'package:super_career_ai/Features/jobs/Data/repo_impl/job_repo_impl.dart';
import 'package:super_career_ai/Features/jobs/presentation/view_model/job_cubit.dart/job_cubit.dart';
import 'package:super_career_ai/Features/jobs/presentation/view_model/job_cubit.dart/job_cubit_states.dart';
import 'package:super_career_ai/generated/l10n.dart';
import 'package:super_career_ai/Features/home/presentation/views/home_view.dart';
import 'package:super_career_ai/Features/jobs/presentation/views/jops_matches_view.dart';
import 'package:super_career_ai/Features/root/presentation/view_model/navigation_cubit.dart';
import 'package:super_career_ai/Features/cv/presentation/views/cv_view.dart';

class RootView extends StatefulWidget {
  const RootView({super.key});

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavigationCubit()),
        BlocProvider(
          create: (context) =>
              JobCubit(jobRepo: getIt<JobRepoImpl>())..fetchJobMatches(),
        ),
        BlocProvider(
          create: (context) =>
              ProjectCubit(projectRepo: getIt<ProjectRepoImpl>())
                ..fetchProjectMatches(),
        ),
      ],
      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, currentIndex) {
          return Scaffold(
            body: BlocBuilder<JobCubit, JobCubitStates>(
              builder: (context, jobState) {
                return BlocBuilder<ProjectCubit, ProjectCubitStates>(
                  builder: (context, projectState) {
                    return IndexedStack(
                      index: currentIndex,
                      children: [
                        HomeView(
                          jobState: jobState,
                          projectState: projectState,
                        ),
                        JopsMatchesView(jobState: jobState),
                        ProjectMatchesView(projectState: projectState),
                        CvView(),
                        Scaffold(body: Center(child: Text("Profile"))),
                      ],
                    );
                  },
                );
              },
            ),
            bottomNavigationBar: _buildBottomNavigationBar(
              context,
              currentIndex,
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, int currentIndex) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        border: Border(top: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          context.read<NavigationCubit>().changeIndex(index);
        },
        selectedItemColor: AppColors.primaryBlue,
        unselectedItemColor: AppColors.unselectedIcon,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.cardBackground,
        elevation: 0,
        selectedFontSize: 12.sp,
        unselectedFontSize: 12.sp,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: S.of(context).home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.work_outline),
            activeIcon: const Icon(Icons.work),
            label: S.of(context).jops,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.assignment_outlined),
            activeIcon: const Icon(Icons.assignment),
            label: S.of(context).projects,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.description_outlined),
            activeIcon: const Icon(Icons.description),
            label: S.of(context).cv,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            activeIcon: const Icon(Icons.person),
            label: S.of(context).profile,
          ),
        ],
      ),
    );
  }
}
