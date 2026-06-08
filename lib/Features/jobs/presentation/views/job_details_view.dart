import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/Core/constant/app_colors.dart';
import 'package:super_career_ai/Features/jobs/Domain/entities/jobs_entity.dart';
import 'package:super_career_ai/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class JobDetailsView extends StatelessWidget {
  final JobEntity job;

  const JobDetailsView({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final score = job.matchScore;

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
          s.jobDetails,
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
                      color: const Color(0xFF0F172A),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.work_outline,
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
                      color: AppColors.primaryBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star,
                          color: AppColors.primaryBlue,
                          size: 16.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          s.matchScore(score),
                          style: TextStyle(
                            color: AppColors.primaryBlue,
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

              // Job Title & Info
              Text(
                job.title,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              // company and location
              Text(
                '${job.company} • ${job.location}',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 4.h),
              // remote
              Text(
                '(${s.remote})',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14.sp,
                ),
              ),

              SizedBox(height: 32.h),

              // The Role Section
              _buildSectionTitle(context, s.theRole),
              // description
              SizedBox(height: 12.h),
              Text(
                job.description,
                style: TextStyle(
                  color: AppColors.textPrimary.withOpacity(0.8),
                  fontSize: 15.sp,
                  height: 1.6,
                ),
              ),

              SizedBox(height: 32.h),

              // Requirements Section
              _buildSectionTitle(context, s.requirements),
              SizedBox(height: 16.h),
              _buildRequirementItem(
                context,
                '5+ years experience with React and modern frontend ecosystems.',
              ),
              _buildRequirementItem(
                context,
                'Expertise in TypeScript and state management patterns.',
              ),
              _buildRequirementItem(
                context,
                'Deep understanding of CSS-in-JS or Tailwind CSS utility patterns.',
              ),
              _buildRequirementItem(
                context,
                'Proven track record of delivering pixel-perfect interfaces.',
              ),

              SizedBox(height: 40.h),

              // create custom cv
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
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
                    Icon(Icons.assignment_ind_outlined, size: 20.sp),
                    SizedBox(width: 8.w),
                    Text(
                      s.createCustomCV,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              // view now button
              TextButton(
                onPressed: () => _launchUrl(context, job.sourceUrl),
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

  //build section title
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

  Widget _buildRequirementItem(BuildContext context, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle_outline,
            color: AppColors.primaryBlue,
            size: 20.sp,
          ),
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
