import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_career_ai/Core/constant/app_colors.dart';
import 'package:super_career_ai/Core/navigator/app_routes.dart';
import 'package:super_career_ai/Core/services/locator_service/service_locator.dart';
import 'package:super_career_ai/Features/jobs/Data/repo_impl/job_repo_impl.dart';
import 'package:super_career_ai/Features/jobs/presentation/view_model/create_custom_cv_cubit/create_custom_cv_cubit.dart';
import 'package:super_career_ai/Features/jobs/presentation/view_model/create_custom_cv_cubit/create_custom_cv_states.dart';
import 'package:super_career_ai/Features/jobs/presentation/widgets/cv_editor/cv_upload_box.dart';
import 'package:super_career_ai/Features/jobs/presentation/widgets/cv_editor/recent_document_list.dart';
import 'package:super_career_ai/generated/l10n.dart';

class CvEditorView extends StatelessWidget {
  final int jobId;
  
  const CvEditorView({super.key, required this.jobId});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    
    return BlocProvider(
      create: (context) => CreateCustomCvCubit(jobRepo: getIt<JobRepoImpl>()),
      child: BlocConsumer<CreateCustomCvCubit, CreateCustomCvStates>(
        listener: (context, state) {
          if (state is CreateCustomCvSuccess) {
            context.push(AppRoutes.generatedCvPreviewScreen, extra: state.cvModel);
          } else if (state is CreateCustomCvFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is CreateCustomCvLoading;

          return Scaffold(
            backgroundColor: const Color(0xFFF8FAFC), // Light slate background for premium feel
            // app bar 
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              scrolledUnderElevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
                onPressed: () => context.pop(),
              ),
              centerTitle: true,
              title: Text(
                s.cvEditor,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(1.h),
                child: Container(
                  color: AppColors.border.withOpacity(0.5),
                  height: 1.h,
                ),
              ),
            ),
            body: Stack(
              children: [
                // Scrollable Content
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                    top: 24.h,
                    bottom: 100.h, // padding for the fixed bottom button
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Upload Title
                      Text(
                        s.uploadYourCv,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      
                      // Upload Box Widget
                      const CvUploadBox(),
                      
                      SizedBox(height: 32.h),
                      
                      // Recent Documents Section
                      const RecentDocumentList(),
                    ],
                  ),
                ),
                
                // Fixed Bottom Button
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, -4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: isLoading ? null : () {
                        context.read<CreateCustomCvCubit>().createCustomCV(jobId: jobId);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        minimumSize: Size(double.infinity, 56.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: isLoading 
                          ? SizedBox(
                              width: 24.w, 
                              height: 24.w, 
                              child: const CircularProgressIndicator(color: Colors.white)
                            )
                          : Text(
                              s.createCustomCV,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
