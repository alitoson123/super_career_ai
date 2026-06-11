import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/Core/constant/app_colors.dart';
import 'package:super_career_ai/Features/jobs/Data/models/base_cv_model/base_cv_model.dart';
import 'package:super_career_ai/Features/jobs/presentation/view_model/custom_cv_history_cubit/custom_cv_history_cubit.dart';
import 'package:super_career_ai/Features/jobs/presentation/view_model/custom_cv_history_cubit/custom_cv_history_states.dart';
import 'package:super_career_ai/Features/jobs/presentation/widgets/cv_history_item.dart';
import 'package:super_career_ai/generated/l10n.dart';

class CVHistoryBody extends StatelessWidget {
  const CVHistoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    List<BaseCvModel> historyItems;

    return BlocBuilder<CustomCvHistoryCubit, CustomCvHistoryStates>(
      builder: (context, state) {
        if (state is CustomCvHistoryLoading) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.primaryBlue),
          );
        }
        if (state is CustomCvHistorySuccess) {
          historyItems = state.cvs;
          if (historyItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history_rounded,
                    size: 64.sp,
                    color: AppColors.unselectedIcon.withValues(alpha: 0.5),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    s.noHistory,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                await context
                    .read<CustomCvHistoryCubit>()
                    .fetchCustomCvHistory();
              },
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                physics: const BouncingScrollPhysics(),
                itemCount: historyItems.length,
                itemBuilder: (context, index) {
                  final item = historyItems[index];
                  return CvHistoryCard(item: item);
                },
              ),
            );
          }
        } else if (state is CustomCvHistoryFailure) {
          return Center(child: Text(state.errorMessage));
        }
        return const Center(child: Text("Something went wrong"));
      },
    );
  }
}
