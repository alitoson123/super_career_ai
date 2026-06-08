import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/Core/constant/app_colors.dart';
import 'package:super_career_ai/Features/Projects/Domain/entities/project_entity.dart';
import 'package:super_career_ai/Features/Projects/presentation/widgets/project_top_match_card.dart';
import 'package:super_career_ai/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailsView extends StatelessWidget {
  final ProjectEntity project;

  const ProjectDetailsView({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final score = project.matchScore;
    const Color projectColor = Color(0xFF6366F1); // Indigo

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          s.projectDetails,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo
                  Container(
                    width: 64.w,
                    height: 64.w,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [projectColor, Color(0xFF818CF8)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.rocket_launch_outlined,
                        color: Colors.white,
                        size: 32.sp,
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Match Badge
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: projectColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star, color: projectColor, size: 16.sp),
                        SizedBox(width: 4.w),
                        Text(
                          s.matchScore(score),
                          style: TextStyle(
                            color: projectColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // Project Title & Info
              Text(
                project.title,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              // platform name and budget
              Text(
                '${project.platformName} • ${project.budget ?? project.duration ?? ""}',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                '(${s.remote})',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14.sp,
                ),
              ),

              SizedBox(height: 32.h),

              // The Project Section
              _buildSectionTitle(context, s.theProject),
              SizedBox(height: 12.h),
              // description
              Text(
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                project.description,
                style: TextStyle(
                  color: AppColors.textPrimary.withOpacity(0.8),
                  fontSize: 15.sp,
                  height: 1.6,
                ),
              ),

              SizedBox(height: 32.h),

              // Requirements Section (Required Skills)
              _buildSectionTitle(context, s.requirements),
              SizedBox(height: 16.h),
              ...project.requiredSkills.map(
                (skill) => _buildRequirementItem(
                  context,
                  skill.toString(),
                  projectColor,
                ),
              ),

              SizedBox(height: 40.h),

              // Bottom Buttons
              ElevatedButton(
                onPressed: () => show(context, project),

                style: ElevatedButton.styleFrom(
                  backgroundColor: projectColor,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 56.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.send_outlined, size: 20.sp),
                    SizedBox(width: 8.w),
                    Text(
                      s.customProposal,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              TextButton(
                onPressed: () => _launchUrl(context, project.sourceUrl),
                style: TextButton.styleFrom(
                  minimumSize: Size(double.infinity, 56.h),
                  backgroundColor: const Color(0xFFF1F5F9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Text(
                  s.applyNow,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(S.of(context).failedToOpenLink)));
      }
    }
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildRequirementItem(BuildContext context, String text, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle_outline, color: color, size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: AppColors.textPrimary.withOpacity(0.8),
                fontSize: 14.sp,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
