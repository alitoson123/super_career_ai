import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/Core/constant/app_colors.dart';
import 'package:super_career_ai/generated/l10n.dart';

class ProposalHistoryBody extends StatelessWidget {
  const ProposalHistoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    // Mock data for demonstration
    final List<Map<String, dynamic>> historyItems = [
      {'title': 'UX/UI Design for FinTec...', 'date': 'Oct 12, 2023'},
      {'title': 'Landing Page for SaaS Pro', 'date': 'Oct 12, 2023'},
      {'title': 'E-commerce Website Re...', 'date': 'Oct 12, 2023'},
      {'title': 'Brand Identity - Coffee L...', 'date': 'Oct 12, 2023'},
      {'title': 'Mobile CRM Dashboard', 'date': 'Oct 12, 2023'},
    ];

    // no history
    if (historyItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history_rounded,
              size: 64.sp,
              color: AppColors.unselectedIcon.withOpacity(0.5),
            ),
            SizedBox(height: 16.h),
            Text(
              s.noHistory,
              style: TextStyle(color: AppColors.textSecondary, fontSize: 16.sp),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      physics: const BouncingScrollPhysics(),
      itemCount: historyItems.length,
      itemBuilder: (context, index) {
        final item = historyItems[index];
        return _buildHistoryCard(context, item);
      },
    );
  }

  Widget _buildHistoryCard(BuildContext context, Map<String, dynamic> item) {
    const Color projectColor = Color(0xFF6366F1); // Indigo

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppColors.border.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // project title
          Text(
            item['title'],
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.h),
          const Divider(height: 1),
          SizedBox(height: 16.h),
          // date and copy button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // date
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 14.sp,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    item['date'],
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              //copy button
              Container(
                decoration: BoxDecoration(
                  color: projectColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.copy_rounded,
                    color: Colors.white,
                    size: 18.sp,
                  ),
                  constraints: BoxConstraints.tightFor(
                    width: 40.w,
                    height: 40.w,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
