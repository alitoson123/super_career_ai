import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/Core/constant/app_colors.dart';
import 'package:super_career_ai/Features/Projects/Domain/entities/project_entity.dart';
import 'package:super_career_ai/Features/Projects/presentation/view_model/project_cubit.dart/project_cubit.dart';
import 'package:super_career_ai/generated/l10n.dart';
import 'project_top_match_card.dart';

class ProjectMatchesViewBody extends StatefulWidget {
  final List<ProjectEntity> projects;
  const ProjectMatchesViewBody({super.key, required this.projects});

  @override
  State<ProjectMatchesViewBody> createState() => _ProjectMatchesViewBodyState();
}

class _ProjectMatchesViewBodyState extends State<ProjectMatchesViewBody> {
  //int _selectedChipIndex = 0;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    // final List<String> chips = [s.allMatches, s.highScore];

    return RefreshIndicator(
      onRefresh: () async {
        await context.read<ProjectCubit>().fetchProjectMatches();
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
                      color: const Color(0xFF6366F1).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      s.foundCount(widget.projects.length),
                      style: TextStyle(
                        color: const Color(0xFF6366F1),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // List
              if (widget.projects.isNotEmpty) ...[
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.projects.length,
                  itemBuilder: (context, index) {
                    final project = widget.projects[index];
                    return PtojectTopMatchCard(project: project);
                  },
                ),
              ] else
                Column(
                  children: [
                    Center(
                      child: Text(
                        s.noProjectMatchesFound,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // retry
                        context.read<ProjectCubit>().fetchProjectMatches();
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
