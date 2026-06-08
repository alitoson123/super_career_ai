import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/Core/constant/app_colors.dart';
import 'package:super_career_ai/Features/Projects/presentation/view_model/project_cubit.dart/project_cubit_states.dart';
import 'package:super_career_ai/Features/jobs/presentation/view_model/job_cubit.dart/job_cubit_states.dart';
import 'package:super_career_ai/generated/l10n.dart';
import 'package:super_career_ai/Core/navigator/app_routes.dart';
import 'package:go_router/go_router.dart';
import '../widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
    required this.jobState,
    required this.projectState,
  });
  final JobCubitStates jobState;
  final ProjectCubitStates projectState;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: HomeViewBody(jobState: jobState, projectState: projectState),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      scrolledUnderElevation: 0,
      // title of app
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bolt, color: AppColors.primaryBlue, size: 28.sp),
          SizedBox(width: 4.w),
          Text(
            S.of(context).superCareer,
            style: TextStyle(
              color: AppColors.primaryBlue,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          ),
        ],
      ),
      centerTitle: true,
      // notification icon and profile image
      actions: [
        IconButton(
          icon: Icon(
            Icons.notifications_none,
            color: AppColors.textPrimary,
            size: 26.sp,
          ),
          onPressed: () => context.push(AppRoutes.notificationsScreen),
        ),
      ],
    );
  }
}
