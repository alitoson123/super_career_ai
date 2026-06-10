import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/Core/constant/app_colors.dart';
import 'package:super_career_ai/Features/jobs/presentation/view_model/base_cv_cubit.dart/get_base_cv_cubit.dart';
import 'package:super_career_ai/Features/jobs/presentation/view_model/base_cv_cubit.dart/get_base_cv_states.dart';
import 'package:super_career_ai/Features/jobs/presentation/widgets/cv_editor/recent_document_card.dart';
import 'package:super_career_ai/generated/l10n.dart';

class RecentDocumentList extends StatelessWidget {
  const RecentDocumentList({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              s.recentDocument,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),

        // List Body
        BlocBuilder<BaseCvCubit, BaseCvStates>(
          builder: (context, state) {
            if (state is BaseCvLoading) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.h),
                  child: CircularProgressIndicator(
                    color: AppColors.primaryBlue,
                  ),
                ),
              );
            }
            if (state is BaseCvSuccess) {
              final items = state.baseCv;
              if (items == null) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 32.h),
                    child: Text(
                      s.noBaseCvTryToUploadOne,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                );
              }
              return RecentDocumentCard(item: items);
            }
            if (state is BaseCvFailure) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.h),
                  child: Text(
                    state.errorMessage,
                    style: TextStyle(color: Colors.redAccent, fontSize: 14.sp),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
